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

  Future<List<ManagementEventViewModel>> _getMusiciansEvent() async {
    try {
      return await _eventController.selectMusicianEvent(_store.id);
    } catch (e) {
      throw e;
    }
  }

  Future<void> _refreshListEvents() async {
    try {
      final newList = await _getMusiciansEvent();

      setState(() {
        _listEvents = newList;
      });
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
    ).then((_) => _refreshListEvents());
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
              children: <Widget>[
                TextButtonWidget(
                  icon: Icons.date_range,
                  title: "Todos",
                  onPress: () {},
                  isActive: true,
                ),
                TextButtonWidget(
                  icon: Icons.calendar_today,
                  title: "Pendente",
                  onPress: () {},
                ),
                TextButtonWidget(
                  icon: Icons.event,
                  title: "Aberto",
                  onPress: () {},
                ),
                TextButtonWidget(
                  icon: Icons.event_available,
                  title: "Concluido",
                  onPress: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ManagementEventViewModel>>(
              future: this._getMusiciansEvent(),
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
        ],
      ),
    );
  }
}
