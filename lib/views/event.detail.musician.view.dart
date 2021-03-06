import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/utils/date.utils.dart';
import 'package:tcc_bora_show/utils/location.utils.dart';
import 'package:tcc_bora_show/view-models/event.detail.viewmodel.dart';
import 'package:tcc_bora_show/widgets/description.widget.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.detail.appbar.widget.dart';
import 'package:tcc_bora_show/widgets/event.musician.list.widget.dart';
import 'package:tcc_bora_show/widgets/info.box.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';

class EventDetailMusicianView extends StatefulWidget {
  final String eventID;

  const EventDetailMusicianView({
    Key? key,
    required this.eventID,
  }) : super(key: key);

  @override
  _EventDetailMusicianViewState createState() =>
      _EventDetailMusicianViewState();
}

class _EventDetailMusicianViewState extends State<EventDetailMusicianView> {
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
      final musicianID = this._store.id;
      EventDetailViewModel event = await _controller.selectEventDetailMusician(
        musicianID: musicianID,
        eventId: eventID,
      );

      return event;
    } catch (e) {
      throw e;
    }
  }

  _changeMusicianStatus({
    bool remove = false,
    bool confirme = false,
    bool subscribe = false,
  }) async {
    try {
      final model = EventMusicianModel(
        eventID: this._event.id,
        isConfirmed: confirme,
        toRemove: remove,
        musicianID: this._store.id,
      );

      if (subscribe) {
        await _controller.subscribeEvent(model);
      } else {
        await _controller.changeMusicianStatus(model);
      }

      Navigator.pop(context);
    } catch (e) {
      throw e;
    }
  }

  void _createRoute() {
    final event = this._event;

    openAvailableMaps(
      context: context,
      latitude: event.latitude,
      longitude: event.longitude,
      title: event.title,
    );
  }

  Widget _buildActions() {
    final event = this._event;
    final musician = this._event.muscians[0];

    Widget button = LargeButtonWidget(
      onPress: this._createRoute,
      title: "Criar Rota",
    );

    if (event.status == 'pending' &&
        !musician.isInvited &&
        musician.eventID.isEmpty) {
      button = Column(
        children: <Widget>[
          LargeButtonWidget(
            title: "Inscrever-se",
            color: Colors.green,
            onPress: () => this._changeMusicianStatus(subscribe: true),
          ),
          LargeButtonWidget(
            onPress: this._createRoute,
            title: "Criar Rota",
          ),
        ],
      );
    }

    if (event.status == 'pending' &&
        !musician.isConfirmed &&
        musician.isInvited) {
      button = Column(
        children: [
          LargeButtonWidget(
            title: "Aceitar",
            onPress: () => this._changeMusicianStatus(confirme: true),
          ),
          LargeButtonWidget(
            title: "Recusar",
            color: Colors.red,
            onPress: () => this._changeMusicianStatus(remove: true),
          ),
        ],
      );
    }

    return button;
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
                    title: "Endere??o",
                    content: event.address,
                  ),
                  DescriptionWidget(
                    title: "Genero",
                    content: event.musicGenre.join("/"),
                  ),
                  DescriptionWidget(title: "Tipo", content: event.type),
                  DescriptionWidget(title: "Sobre", content: event.description),
                  EventMusicianListWidget(title: event.organizerName),
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
              errorTitle: "Error ao carregar conte??dos",
            );
          }

          this._event = snapshot.data!;
          return this._body;
        },
      ),
    );
  }
}
