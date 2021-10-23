import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/utils/date.utils.dart';
import 'package:tcc_bora_show/view-models/event.detail.viewmodel.dart';
import 'package:tcc_bora_show/widgets/description.widget.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.detail.appbar.widget.dart';
import 'package:tcc_bora_show/widgets/event.musician.list.widget.dart';
import 'package:tcc_bora_show/widgets/info.box.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:tcc_bora_show/widgets/large.outlinebutton.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';

class EventDetailOrganizerView extends StatefulWidget {
  final String eventID;

  const EventDetailOrganizerView({Key? key, required this.eventID})
      : super(key: key);

  @override
  _EventDetailOrganizerViewState createState() =>
      _EventDetailOrganizerViewState();
}

class _EventDetailOrganizerViewState extends State<EventDetailOrganizerView> {
  late EventDetailViewModel _event;
  final _controller = EventController();
  late ProfileStore _store;
  String _eventID = "";

  @override
  void initState() {
    super.initState();
    this._eventID = widget.eventID;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
  }

  Future<EventDetailViewModel> _getEventDetail() async {
    try {
      final eventID = this._eventID;

      final event = await _controller.selectEventDetailOrganizer(eventID);

      return event;
    } catch (e) {
      throw e;
    }
  }

  _changeEventStatus(EventDetailViewModel event) async {
    try {
      this._controller.changeEvent(event);

      Navigator.pop(context);
    } catch (e) {
      throw e;
    }
  }

  Widget _buildActions() {
    final event = this._event;

    Widget button = Container();

    if (event.status == 'pending') {
      event.status = 'open';

      button = LargeButtonWidget(
        title: "Abrir",
        onPress: () => this._changeEventStatus(event),
      );
    } else if (event.status != "cancelled") {
      button = LargeButtonWidget(
        onPress: () {
          event.status = "cancelled";
          this._changeEventStatus(event);
        },
        title: "Cancelar",
        color: Colors.red,
      );
    }

    return button;
  }

  Widget _buildMusiciansList(List<EventMusicianModel> musicians) {
    List<Widget> musiciansWidget = [];

    musiciansWidget = musicians.map<Widget>((musician) {
      return EventMusicianListWidget(
        title: musician.name,
        icon: Icons.delete,
        onPressed: () {},
      );
    }).toList();

    return Column(
      children: <Widget>[
        ...musiciansWidget,
        LargeOutlineButtonWidget(
          title: "Adicionar",
          onPress: () {},
        )
      ],
    );
  }

  Widget get _body {
    final event = this._event;

    return CustomScrollView(
      slivers: [
        EventDetailAppBarWidget(title: event.title),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoBoxWidget(
                        title: "Data",
                        content: dateFormat(event.date),
                      ),
                      InfoBoxWidget(
                        title: "Hora",
                        content: timeFormat(event.time),
                      ),
                    ],
                  ),
                  DescriptionWidget(
                    title: "Endereço",
                    content: event.address,
                  ),
                  DescriptionWidget(
                    title: "Genero",
                    content: event.musicGenre.join("/"),
                  ),
                  DescriptionWidget(title: "Tipo", content: event.type),
                  DescriptionWidget(title: "Sobre", content: event.description),
                  this._buildMusiciansList(event.muscians),
                  this._buildActions(),
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<EventDetailViewModel>(
        future: this._getEventDetail(),
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

          this._event = snapshot.data!;
          return this._body;
        },
      ),
    );
  }
}
