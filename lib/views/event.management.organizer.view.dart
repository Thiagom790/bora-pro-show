import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';
import 'package:tcc_bora_show/views/create.event.view.dart';
import 'package:tcc_bora_show/views/edit.event.view.dart';
import 'package:tcc_bora_show/views/event.detail.organizer.dart';
import 'package:tcc_bora_show/widgets/dismissible.card.widget.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.card.container.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/text.button.widget.dart';

class EventManagementOrganizerView extends StatefulWidget {
  const EventManagementOrganizerView({Key? key}) : super(key: key);

  @override
  _EventManagementOrganizerViewState createState() =>
      _EventManagementOrganizerViewState();
}

class _EventManagementOrganizerViewState
    extends State<EventManagementOrganizerView> {
  final _eventController = EventController();
  late ProfileStore _store;
  List<ManagementEventViewModel> _listEvents = [];
  String? _status;

  Future<List<ManagementEventViewModel>> _getMusiciansEvent({
    String? status,
  }) async {
    try {
      return await _eventController.selectEventsOrganizer(
        _store.id,
        status: status,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> _removeEvent(String eventID) async {
    try {
      await this._eventController.removeEvent(eventID);
    } catch (e) {
      print("Erro dentro de event manager organizer em excluir um evento");
    } finally {
      setState(() {});
    }
  }

  void _openEditEvent(EventModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditEventView(event: model)),
    ).then((_) => setState(() {}));

    setState(() {});
  }

  void _openEventDetail(EventModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailOrganizerView(eventID: model.id),
      ),
    ).then((_) => setState(() {}));
  }

  void _openCreateEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateEventView()),
    ).then((_) => setState(() {}));
  }

  Widget _buildListEvents(List<ManagementEventViewModel> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return DismissibleCardWidget(
          keyValue: event.id,
          onDismissToRight: () => this._openEditEvent(event),
          onDismissToLeft: () => this._removeEvent(event.id),
          child: EventCardContainerWidget(
            event: event,
            onPress: () => this._openEventDetail(event),
          ),
        );
      },
    );
  }

  List<Widget> get _filterWidgets {
    List<Map<String, dynamic>> filtersInfo = [
      {'name': "Todos", "status": null, "icon": Icons.date_range},
      {'name': "Pendente", "status": "pending", "icon": Icons.calendar_today},
      {'name': "Aberto", "status": "open", "icon": Icons.event},
      {
        'name': "Cancelado",
        "status": "cancelled",
        "icon": Icons.event_available
      },
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
                    errorTitle: "Error ao carregar conteúdos",
                  );
                }

                _listEvents = snapshot.data!;

                return this._buildListEvents(_listEvents);
              },
            ),
          ),
          LargeButtonWidget(
              onPress: this._openCreateEvent, title: "Criar Evento")
        ],
      ),
    );
  }
}
