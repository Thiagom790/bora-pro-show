import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/controllers/post.controller.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/models/post.model.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.card.musician.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/musician.summary.widget.dart';
import 'package:tcc_bora_show/widgets/post.widget.dart';

class MusicianVisitProfileView extends StatefulWidget {
  final String musicianID;
  const MusicianVisitProfileView({required this.musicianID, Key? key})
      : super(key: key);

  @override
  _MusicianVisitProfileViewState createState() =>
      _MusicianVisitProfileViewState();
}

class _MusicianVisitProfileViewState extends State<MusicianVisitProfileView> {
  late String _musicianID;
  // store
  late ProfileStore _store;
  // Perfil
  final _profileController = ProfileController();
  late ProfileModel _profileModel;
  // Eventos
  final _eventController = EventController();
  List<ManagementEventViewModel> _listEvents = [];
  // Post
  final _postController = PostController();
  List<PostModel> _listPosts = [];
  bool _userFollowMusician = false;

  @override
  void initState() {
    super.initState();
    _musicianID = widget.musicianID;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
  }

  Future<void> _selectProfile() async {
    try {
      String musicianID = _musicianID;
      _profileModel = await _profileController.selectProfile(musicianID);
    } catch (e) {
      throw e;
    }
  }

  Future<void> _selectListEvents() async {
    try {
      final musicianID = _musicianID;
      final listEvents = await _eventController.selectMusicianEvent(musicianID);

      this._listEvents = listEvents;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _selectPostMusician() async {
    try {
      final musicianID = _musicianID;
      final listPosts = await _postController.selectPostsMusician(musicianID);

      this._listPosts = listPosts;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _getUserFollowMusician() async {
    try {
      final musicianID = _musicianID;
      final userID = _store.id;
      final userFollowMusician = await _postController.userFollowMusician(
        userID: userID,
        musicianID: musicianID,
      );

      this._userFollowMusician = userFollowMusician;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _loadScreen() async {
    try {
      await _selectListEvents();
      await _selectProfile();
      await _selectPostMusician();
      await _getUserFollowMusician();
    } catch (e) {
      throw e;
    }
  }

  Future<void> followMusician() async {
    try {
      final userID = _store.id;
      final musicianID = this._musicianID;

      await _postController.followMusician(
          userID: userID, musicianID: musicianID);

      Navigator.pop(context);
    } catch (e) {
      print("Erro ao seguir musico");
    }
  }

  Future<void> unFollowMusician() async {
    try {
      final userID = _store.id;
      final musicianID = this._musicianID;

      await _postController.unFollowMusician(
        userID: userID,
        musicianID: musicianID,
      );

      setState(() {});
    } catch (e) {
      print("Erro ao deixar de seguir musico");
    }
  }

  // Widgets
  List<Widget> get postsWidgets {
    return this._listPosts.map((post) => Postwidget(postModel: post)).toList();
  }

  List<Widget> get listEventsWidget {
    List<Widget> list = [];
    final events = this._listEvents;

    if (events.isEmpty) {
      list.add(EventCardMusician(title: "Sem Eventos"));
      return list;
    }

    list = events.map<Widget>((event) {
      return EventCardMusician(
        title: event.title,
      );
    }).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<void>(
        future: _loadScreen(),
        builder: (context, snapshot) {
          if (ConnectionState.none == snapshot.connectionState ||
              ConnectionState.waiting == snapshot.connectionState) {
            return LoadingWidget();
          }
          if (ConnectionState.done == snapshot.connectionState &&
              snapshot.hasError) {
            String error = snapshot.error.toString();
            print("Erro de carregamento de eventos: " + error);
            return ErrorCustomWidget(
              errorTitle: "Erro ao carregar informações",
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MusicianSummaryWidget(
                  profileModel: this._profileModel,
                  buttonTitle:
                      this._userFollowMusician ? "Parar de Seguir" : "Seguir",
                  onPressedButton: this._userFollowMusician
                      ? this.unFollowMusician
                      : this.followMusician,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Últimos Eventos",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 10),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: listEventsWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    this._listPosts.length > 0
                        ? "Postagens"
                        : "Músico ainda não tem postagens",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                ...postsWidgets,
              ],
            ),
          );
        },
      ),
    );
  }
}
