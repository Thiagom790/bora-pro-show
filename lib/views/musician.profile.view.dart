import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/auth.controller.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/controllers/post.controller.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/post.model.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/store/auth.store.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';
import 'package:tcc_bora_show/view-models/profile.viewmodel.dart';
import 'package:tcc_bora_show/views/create.post.view.dart';
import 'package:tcc_bora_show/views/event.detail.musician.view.dart';
import 'package:tcc_bora_show/widgets/dismissible.card.widget.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.card.musician.widget.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/musician.summary.widget.dart';
import 'package:tcc_bora_show/widgets/post.widget.dart';
import 'package:tcc_bora_show/widgets/profile.popupmenu.widget.dart';

import 'create.profile.view.dart';

class MusicianProfileView extends StatefulWidget {
  const MusicianProfileView({Key? key}) : super(key: key);

  @override
  _MusicianProfileViewState createState() => _MusicianProfileViewState();
}

class _MusicianProfileViewState extends State<MusicianProfileView> {
  final _controller = ProfileController();
  late ProfileStore _profileStore;
  ProfileModel profileModel = new ProfileModel();
  late ProfileViewModel _defaultProfile;
  late ReactionDisposer _disposer;
  List<ProfileViewModel> _profiles = [];
  final _authController = AuthController();
  late AuthStore _authStore;
  final _eventController = EventController();
  List<ManagementEventViewModel> _listEvents = [];
  final _postController = PostController();
  List<PostModel> _listPosts = [];

  Future<void> _selectProfile() async {
    try {
      profileModel = await _controller.currentProfile();
    } catch (e) {
      throw e;
    }
  }

  Future<void> _selectListEvents() async {
    try {
      final musicianID = _profileStore.id;
      final listEvents = await _eventController.selectMusicianEvent(musicianID);

      this._listEvents = listEvents;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _selectPostMusician() async {
    try {
      final musicianID = _profileStore.id;
      final listPosts = await _postController.selectPostsMusician(musicianID);

      this._listPosts = listPosts;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _loadScreen() async {
    try {
      await _selectListEvents();
      await _selectProfile();
      await _selectPostMusician();
    } catch (e) {
      throw e;
    }
  }

  // Contrução de widgets
  List<Widget> get postsWidgets {
    return this._listPosts.map((post) {
      return DismissibleCardWidget(
        child: Postwidget(postModel: post),
        keyValue: post.id,
        onDismissToLeft: () {},
      );
    }).toList();
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
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailMusicianView(eventID: event.id),
            ),
          );
        },
      );
    }).toList();

    return list;
  }

  //Cabeçalho
  Future<void> _getUserProfiles() async {
    try {
      var profiles = await _controller.getUserProfiles();
      var profileID = this._profileStore.id;
      var profile = profiles.firstWhere((prof) => prof.id == profileID);

      setState(() {
        this._profiles = profiles;
        this._defaultProfile = profile;
      });
    } catch (e) {
      print("Erro dentro de ProfileView ao carregar perfils");
    }
  }

  void _onSelectProfile(ProfileViewModel profile) {
    print("Print de dentro de profileview " + profile.id);
    setState(() {});

    _controller.changeCurrentUserProfile(profileId: profile.id).then((data) {
      print("Datos apos a troca" + data.id);
      _profileStore.setProfile(
        userUid: data.id,
        role: data.role,
        name: data.name,
        id: data.id,
      );

      setState(() {});
    }).catchError((error) {
      print("erro da tela" + error.message);

      setState(() {});
    });
  }

  void _createNewProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateProfileView()),
    );
  }

  void _logout() {
    _authController.logout().then((_) {
      this._authStore.changeAuth(userIsAuth: false);
    }).catchError((error) {
      print("Erro dentro de profile view na logout" + error.toString());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._profileStore = Provider.of<ProfileStore>(context);
    this._authStore = Provider.of<AuthStore>(context);
    this._disposer = reaction((_) => this._profileStore.id, (idProfile) {
      _getUserProfiles();
    });

    _getUserProfiles();
  }

  @override
  void dispose() {
    this._disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadScreen(),
      builder: (context, snapshot) {
        if (ConnectionState.none == snapshot.connectionState ||
            ConnectionState.waiting == snapshot.connectionState) {
          return LoadingWidget();
        }
        if (ConnectionState.done == snapshot.connectionState &&
            snapshot.hasError) {
          String error = snapshot.error.toString();
          return ErrorCustomWidget(errorTitle: error);
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ProfilePopupMenuWidget(
                    profiles: this._profiles,
                    defaultProfile: this._defaultProfile,
                    onSelect: this._onSelectProfile,
                    onCreateProfile: this._createNewProfile,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: AppColors.textLight,
                    ),
                    onPressed: this._logout,
                  ),
                ],
              ),
              MusicianSummaryWidget(profileModel: profileModel),
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
              InputWidget(
                placeholder: "No que você está pensando?",
                readOnly: true,
                borderColor: AppColors.textLight,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Createpostview()),
                  ).then((_) => setState(() {}));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  this._listPosts.length > 0
                      ? "Postagens"
                      : "Você ainda não possui postagens ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              ...postsWidgets,
            ],
          ),
        );
      },
    );
  }
}
