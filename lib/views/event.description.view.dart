import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/views/splash.view.dart';
import 'package:tcc_bora_show/widgets/description.widget.dart';
import 'package:tcc_bora_show/widgets/info.box.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDescriptionView extends StatefulWidget {
  final eventID;

  EventDescriptionView({
    required this.eventID,
  });

  @override
  _EventDescriptionViewState createState() => _EventDescriptionViewState();
}

class _EventDescriptionViewState extends State<EventDescriptionView> {
  final _controller = EventController();
  late String _eventId;
  late EventModel _event;

  openMapsSheet(context) async {
    try {
      final coords = Coords(_event.latitude, _event.longitude);
      final title = _event.title;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this._eventId = widget.eventID;
  }

  Future<EventModel> _getEvent() async {
    return await this._controller.selectEvent(this._eventId);
  }

  Widget get _eventDescription {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._event.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InfoBoxWidget(
                  title: 'Data:',
                  content: "19/09",
                ),
                InfoBoxWidget(
                  title: 'Hora:',
                  content: "88",
                ),
              ],
            ),
            DescriptionWidget(
              title: "Endereço",
              content: this._event.address,
            ),
            DescriptionWidget(
              title: "Genero",
              content: _event.description,
            ),
            DescriptionWidget(
              title: "Sobre",
              content: this._event.description,
            ),
            LargeButtonWidget(
                onPress: () => openMapsSheet(context), title: "Criar Rota"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventModel>(
      future: this._getEvent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          this._event = snapshot.data!;
          return this._eventDescription;
        }

        return SplashView();
      },
    );
  }
}
