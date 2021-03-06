import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';
import 'package:tcc_bora_show/views/event.detail.musician.view.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.card.container.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/text.button.widget.dart';

class EventManagementView extends StatefulWidget {
  const EventManagementView({Key? key}) : super(key: key);

  @override
  _EventManagementViewState createState() => _EventManagementViewState();
}

class _EventManagementViewState extends State<EventManagementView> {
  final _eventController = EventController();
  late ProfileStore _store;
  List<ManagementEventViewModel> _listEvents = [];
  String? _status;

  Future<List<ManagementEventViewModel>> _getMusiciansEvent({
    String? status,
  }) async {
    try {
      return await _eventController.selectMusicianEvent(
        _store.id,
        status: status,
      );
    } catch (e) {
      throw e;
    }
  }

  void _openEventDetailView(String eventID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailMusicianView(
          eventID: eventID,
        ),
      ),
    ).then((_) => setState(() {}));
  }

  Widget _buildListEvents(List<ManagementEventViewModel> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return EventCardContainerWidget(
          event: event,
          onPress: () => _openEventDetailView(event.id),
        );
      },
    );
  }

  List<Widget> get _filterWidgets {
    List<Map<String, dynamic>> filtersInfo = [
      {'name': "Todos", "status": null, "icon": Icons.date_range},
      {'name': "Pendente", "status": "pending", "icon": Icons.calendar_today},
      {'name': "Aberto", "status": "open", "icon": Icons.event},
    ];

    final listFilters = filtersInfo.map<Widget>((info) {
      return TextButtonWidget(
        title: info['name'],
        icon: info["icon"],
        isActive: _status == info['status'],
        onPress: () => setState(() => _status = info['status']),
      );
    }).toList();

    return listFilters;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filterWidgets,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ManagementEventViewModel>>(
              future: this._getMusiciansEvent(status: this._status),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget();
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasError) {
                  String error = snapshot.error.toString();
                  print("Erro dentro da tela select musician view " + error);
                  return ErrorCustomWidget(
                    errorTitle: "Error ao carregar conte??dos",
                  );
                }

                _listEvents = snapshot.data!;

                return this._buildListEvents(_listEvents);
              },
            ),
          ),
        ],
      ),
    );
  }
}
