import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
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

class EventDetailVisitantView extends StatefulWidget {
  final eventID;

  EventDetailVisitantView({
    required this.eventID,
  });

  @override
  _EventDetailVisitantViewState createState() =>
      _EventDetailVisitantViewState();
}

class _EventDetailVisitantViewState extends State<EventDetailVisitantView> {
  late EventDetailViewModel _event;
  final _controller = EventController();
  String _eventID = "";

  @override
  void initState() {
    super.initState();
    this._eventID = widget.eventID;
  }

  Future<EventDetailViewModel> _getEventDetail() async {
    try {
      final eventID = this._eventID;

      final event = await _controller.selectEventDetailvisitant(eventID);

      return event;
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

  List<Widget> _buildMusiciansList(List<EventMusicianModel> musicians) {
    List<Widget> musiciansWidget = [];

    musiciansWidget = musicians.map<Widget>((musician) {
      return EventMusicianListWidget(title: musician.name);
    }).toList();

    return musiciansWidget;
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
                  ...this._buildMusiciansList(event.muscians),
                  LargeButtonWidget(
                    onPress: this._createRoute,
                    title: "Criar Rota",
                  ),
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
