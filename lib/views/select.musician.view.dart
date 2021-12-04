import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.musician.list.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/musician.searchbar.widget.dart';

class SelectMusicianView extends StatefulWidget {
  const SelectMusicianView({Key? key}) : super(key: key);

  @override
  _SelectMusicianViewState createState() => _SelectMusicianViewState();
}

class _SelectMusicianViewState extends State<SelectMusicianView> {
  final _eventController = EventController();
  final List<EventMusicianModel> _musiciansSelected = [];
  final _searchController = TextEditingController();
  List<EventMusicianModel> _musiciansList = [];
  List<ProfileModel> _profilesMusicians = [];

  Future<List<ProfileModel>> _selectMusicians() async {
    try {
      String musicianName = _searchController.text.trim().toLowerCase();
      final listMusicians = await _eventController.selectMusiciansProfiles();

      if (musicianName.isNotEmpty) {
        return _filterMusician(musicianName, listMusicians);
      }

      return listMusicians;
    } catch (e) {
      throw e;
    }
  }

  void _buildListMusicians(List<ProfileModel> musicians) {
    this._musiciansList = musicians.map<EventMusicianModel>((musician) {
      return EventMusicianModel(
        isSelected: false,
        name: musician.name,
        musicianID: musician.id,
      );
    }).toList();
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

  Widget get _musicianListWidget {
    final musicians = this._musiciansList;

    return StatefulBuilder(builder: (context, setState) {
      return ListView.builder(
        itemCount: musicians.length,
        itemBuilder: (context, index) {
          final musician = musicians[index];
          final isSelected = musician.isSelected;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: isSelected ? AppColors.textAccent : null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: EventMusicianListWidget(
                title: musician.name,
                icon: isSelected ? Icons.check : Icons.add,
                fontSize: 18,
                onPressed: () {
                  setState(() {
                    musician.isSelected = !isSelected;
                    musician.isInvited = true;
                    !isSelected
                        ? this._musiciansSelected.add(musician)
                        : this._musiciansSelected.remove(musician);
                  });
                },
              ),
            ),
          );
        },
      );
    });
  }

  Widget get _body {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          MusicianSearchBar(
            onPressed: () {
              setState(() {});
            },
            controller: _searchController,
          ),
          Expanded(
            child: _musicianListWidget,
          ),
          LargeButtonWidget(
            title: "Confirmar",
            onPress: () {
              Navigator.pop(context, this._musiciansSelected);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleção de Musico'),
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
            print("Erro dentro da tela select musician view " + error);
            return ErrorCustomWidget(
              errorTitle: "Error ao carregar conteúdos",
            );
          }

          this._profilesMusicians = snapshot.data!;
          this._buildListMusicians(_profilesMusicians);

          return _body;
        },
      ),
    );
  }
}
