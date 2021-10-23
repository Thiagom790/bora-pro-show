import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';
import 'package:tcc_bora_show/views/create.event.view.dart';
import 'package:tcc_bora_show/views/event.detail.organizer.dart';
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

  Future<List<ManagementEventViewModel>> _getMusiciansEvent() async {
    try {
      return await _eventController.selectEventsOrganizer(_store.id);
    } catch (e) {
      throw e;
    }
  }

  Widget _buildListEvents(List<ManagementEventViewModel> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailOrganizerView(
                  eventID: event.id,
                ),
              ),
            );
          },
          child: EventCardContainerWidget(event: event),
        );
      },
    );
  }

  void _openCreateEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateEventView()),
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

                final listEvents = snapshot.data!;

                return this._buildListEvents(listEvents);
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
