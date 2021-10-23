import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/utils/date.utils.dart';
import 'package:tcc_bora_show/view-models/event.detail.viewmodel.dart';
import 'package:tcc_bora_show/views/select.musician.view.dart';
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
  String _eventID = "";

  @override
  void initState() {
    super.initState();
    this._eventID = widget.eventID;
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

  _upadeMusicianList(EventMusicianModel musician) async {
    try {
      final musicians = await _controller.updateEventMusicianList(musician);
      setState(() {
        this._event.muscians = musicians;
      });
    } catch (e) {
      throw e;
    }
  }

  _updateAllMusicianList(List<EventMusicianModel> musicians) async {
    final List<EventMusicianModel> eventMusicians = musicians.where((musician) {
      musician.eventID = this._eventID;
      bool exist =
          this._event.muscians.any((e) => e.musicianID == musician.musicianID);

      return !exist;
    }).toList();

    if (eventMusicians.length <= 0) return;

    try {
      final newMusicians =
          await this._controller.updateAllEventMusicians(eventMusicians);

      setState(() {
        this._event.muscians = newMusicians;
      });
    } catch (e) {
      throw e;
    }
  }

  void __openSelectMusicianView() async {
    List<EventMusicianModel>? musicians = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectMusicianView(),
      ),
    );

    if (musicians == null) return;

    this._updateAllMusicianList(musicians);
  }

  Widget _buildMusiciansList(List<EventMusicianModel> musicians) {
    List<Widget> musiciansWidget = [];
    final event = this._event;

    musiciansWidget = musicians.map<Widget>((musician) {
      final removeMusician = () {
        musician.toRemove = true;
        _upadeMusicianList(musician);
      };

      Widget button = EventMusicianListWidget(
        title: musician.name,
        actions: [
          {'icon': Icons.done, 'onPress': () {}},
          {'icon': Icons.delete, 'onPress': removeMusician},
        ],
      );

      if (musician.isConfirmed) {
        button = EventMusicianListWidget(
          title: musician.name,
          color: AppColors.buttonPrimary,
          icon: Icons.delete,
          onPressed: removeMusician,
        );
      } else if (musician.isInvited) {
        button = EventMusicianListWidget(
          title: musician.name,
          icon: Icons.delete,
          onPressed: removeMusician,
        );
      }

      if (event.status != 'pending') {
        button = EventMusicianListWidget(
          title: musician.name,
        );
      }

      return button;
    }).toList();

    return Column(
      children: <Widget>[
        ...musiciansWidget,
        if (event.status == 'pending')
          LargeOutlineButtonWidget(
            title: "Adicionar",
            onPress: this.__openSelectMusicianView,
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
