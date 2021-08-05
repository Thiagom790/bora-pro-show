import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/views/splash.view.dart';
import 'package:tcc_bora_show/widgets/description.widget.dart';
import 'package:tcc_bora_show/widgets/info.box.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';

class EventDescriptionView extends StatefulWidget {
  final eventID;

  EventDescriptionView({
    required this.eventID,
  });

  @override
  _EventDescriptionViewState createState() => _EventDescriptionViewState();
}

class _EventDescriptionViewState extends State<EventDescriptionView> {
  final _controller = EventControlle();
  late String _eventId;
  late EventModel _event;

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.container,
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
                  content: this._event.date,
                ),
                InfoBoxWidget(
                  title: 'Hora:',
                  content: this._event.time,
                ),
              ],
            ),
            DescriptionWidget(
              title: "Endereço",
              content: this._event.address,
            ),
            DescriptionWidget(
              title: "Genero",
              content: this._event.genre,
            ),
            DescriptionWidget(
              title: "Sobre",
              content: this._event.description,
            ),
            LargeButtonWidget(onPress: () {}, title: "Criar Rota"),
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
