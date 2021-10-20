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
import 'package:tcc_bora_show/widgets/loading.widget.dart';

class EventDetailMusicianView extends StatefulWidget {
  final String eventID;

  const EventDetailMusicianView({Key? key, required this.eventID})
      : super(key: key);

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
      final event = await _controller.selectEventDetailMusician(
        musicianID: musicianID,
        eventId: eventID,
      );

      return event;
    } catch (e) {
      throw e;
    }
  }

  _changeMusicianStatus({bool remove = false, bool confirme = true}) async {
    try {
      final model = EventMusicianModel(
        eventID: this._event.id,
        isConfirmed: confirme,
        toRemove: remove,
        musicianID: this._store.id,
      );

      await _controller.changeMusicianStatus(model);

      Navigator.pop(context);
    } catch (e) {
      throw e;
    }
  }

  Widget _buildActions() {
    final event = this._event;
    Widget button = LargeButtonWidget(onPress: () {}, title: "Criar Rota");

    if (event.status == 'pending' && !event.isConfirmed) {
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
                    title: "Endereço",
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
