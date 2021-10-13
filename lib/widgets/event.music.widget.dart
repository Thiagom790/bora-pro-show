import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/views/select.musician.view.dart';
import 'package:tcc_bora_show/widgets/event.musician.list.widget.dart';
import 'package:tcc_bora_show/widgets/large.outlinebutton.widget.dart';

class EventMusicWidget extends StatefulWidget {
  final EventModel model;
  const EventMusicWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _EventMusicWidgetState createState() => _EventMusicWidgetState();
}

class _EventMusicWidgetState extends State<EventMusicWidget> {
  List<EventMusicianModel> _musicianSelected = [];
  late EventModel _eventModel;

  @override
  void initState() {
    super.initState();

    _eventModel = widget.model;
    _musicianSelected = _eventModel.muscians;
  }

  void _setMusiciansList(List<EventMusicianModel> musicians) {
    musicians.forEach((musician) {
      bool exist = this
          ._musicianSelected
          .any((e) => e.musicianID == musician.musicianID);

      if (!exist) {
        this._musicianSelected.add(musician);
      }
    });

    setState(() {
      this._eventModel.muscians = this._musicianSelected;
    });
  }

  void _openSelectMusicianView() async {
    final List<EventMusicianModel>? musicians = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectMusicianView(),
      ),
    );

    if (musicians == null) {
      return;
    }

    _setMusiciansList(musicians);
  }

  List<Widget> get _listWidgetMusicians {
    return this._musicianSelected.map<Widget>((musician) {
      return EventMusicianListWidget(
        title: musician.name,
        icon: Icons.delete,
        onPressed: () {
          setState(() {
            _musicianSelected.remove(musician);
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.container,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ...this._listWidgetMusicians,
            LargeOutlineButtonWidget(
              title: "Adicionar",
              onPress: _openSelectMusicianView,
            )
          ],
        ),
      ),
    );
  }
}
