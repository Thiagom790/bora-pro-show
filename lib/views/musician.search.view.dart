import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/views/musician.visit.profile.view.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.musician.list.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/musician.searchbar.widget.dart';

class MusicianSearchView extends StatefulWidget {
  const MusicianSearchView({Key? key}) : super(key: key);

  @override
  _MusicianSearchViewState createState() => _MusicianSearchViewState();
}

class _MusicianSearchViewState extends State<MusicianSearchView> {
  final _nameMusicianController = TextEditingController();
  final _eventController = EventController();
  List<ProfileModel> _listMusicians = [];

  Future<List<ProfileModel>> _selectMusicians() async {
    try {
      String musicianName = _nameMusicianController.text.trim().toLowerCase();
      final listProfiles = await _eventController.selectMusiciansProfiles();

      if (musicianName.isNotEmpty) {
        return _filterMusician(musicianName, listProfiles);
      }

      return listProfiles;
    } catch (e) {
      throw e;
    }
  }

  List<ProfileModel> _filterMusician(
    String name,
    List<ProfileModel> listMusicians,
  ) {
    final musicians = listMusicians
        .where((musician) => musician.name.toLowerCase().contains(name))
        .toList();

    return musicians;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Músicos'),
      ),
      body: FutureBuilder<List<ProfileModel>>(
        future: this._selectMusicians(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            String error = snapshot.error.toString();
            print("Erro dentro de musician search: " + error);
            return ErrorCustomWidget(errorTitle: "Erro ao carregar conteudos");
          }

          this._listMusicians = snapshot.data!;

          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                MusicianSearchBar(
                  controller: _nameMusicianController,
                  onPressed: () => setState(() {}),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: this._listMusicians.length,
                    itemBuilder: (context, index) {
                      final musician = _listMusicians[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicianVisitProfileView(
                                musicianID: musician.id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: EventMusicianListWidget(
                            title: musician.name,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
