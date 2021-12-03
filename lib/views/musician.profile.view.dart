import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/auth.controller.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/store/auth.store.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/profile.viewmodel.dart';
import 'package:tcc_bora_show/views/create.post.view.dart';
import 'package:tcc_bora_show/widgets/button.widget.dart';
import 'package:tcc_bora_show/widgets/error.custom.widger.dart';
import 'package:tcc_bora_show/widgets/event.card.musician.widget.dart';
import 'package:tcc_bora_show/widgets/event.card.widget.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/musician.summary.widget.dart';
import 'package:tcc_bora_show/widgets/post.widget.dart';
import 'package:tcc_bora_show/widgets/profile.popupmenu.widget.dart';

import 'create.profile.view.dart';

class musicianProfile extends StatefulWidget {
  const musicianProfile({Key? key}) : super(key: key);

  @override
  _musicianProfileState createState() => _musicianProfileState();
}

class _musicianProfileState extends State<musicianProfile> {
  final _controller = ProfileController();
  late ProfileStore _profileStore;
  ProfileModel profileModel = new ProfileModel();
  late ProfileViewModel _defaultProfile;
  late ReactionDisposer _disposer;
  List<ProfileViewModel> _profiles = [];
  bool _isLoading = true;
  final _authController = AuthController();
  late AuthStore _authStore;

  Future<void> _selectProfile() async {
    try {
      profileModel = await _controller.currentProfile();
    } catch (e) {
      throw e;
    }
  }

  //novas funções a partir daqui

  Future<void> _getUserProfiles() async {
    try {
      var profiles = await _controller.getUserProfiles();
      var profileID = this._profileStore.id;
      var profile = profiles.firstWhere((prof) => prof.id == profileID);

      setState(() {
        this._profiles = profiles;
        this._defaultProfile = profile;
        this._isLoading = false;
      });
    } catch (e) {
      print("Erro dentro de ProfileView ao carregar perfils");
    }
  }

  void _onSelectProfile(ProfileViewModel profile) {
    print("Print de dentro de profileview " + profile.id);
    setState(() {
      this._isLoading = true;
    });

    _controller.changeCurrentUserProfile(profileId: profile.id).then((data) {
      print("Datos apos a troca" + data.id);
      _profileStore.setProfile(
        userUid: data.id,
        role: data.role,
        name: data.name,
        id: data.id,
      );


      setState(() {
        this._isLoading = false;
      });
    }).catchError((error) {
      print("erro da tela" + error.message);

      setState(() {
        this._isLoading = false;
      });
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
    _selectProfile(); //se der merda, foi essa linha.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _selectProfile(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
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
              ),
              MusicianSummaryWidget(profileModel: profileModel),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Últimos Eventos",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          EventCardMusician(),
                          EventCardMusician(),
                          EventCardMusician(),
                          EventCardMusician(),
                          EventCardMusician(),
                          EventCardMusician(),
                          EventCardMusician(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.container,
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: TextFormField(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => createpostview()),
                            );
                          },
                          readOnly: true,
                          enabled: true,
                          initialValue: "No que você está pensando?",
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                          style: TextStyle(
                            color: AppColors.textLight,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 0, 5),
                    child: Text(
                      "Postagens",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Postwidget(
                    profileName: "Thiago",
                    postTime: DateTime.now(),
                    postText:
                        "Musica Nova Lançada! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin elementum bibendum risus nec lacinia. In hac habitasse platea dictumst. Mauris eget mi non ligula fringilla sodales non ac augue. Quisque vel consectetur odio. Vivamus scelerisque ex sit amet egestas tempus. Etiam vulputate, metus non dignissim rhoncus, nibh ",
                    likeNumber: 999,
                    commentNumber: 224,
                    profileOnTap: () {},
                    likeOnTap: () {},
                    commentOnTap: () {},
                  ),
                  Postwidget(
                    profileName: "Thiago",
                    postTime: DateTime.now(),
                    postText:
                        "Musica Nova Lançada! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin elementum bibendum risus nec lacinia. In hac habitasse platea dictumst. Mauris eget mi non ligula fringilla sodales non ac augue. Quisque vel consectetur odio. Vivamus scelerisque ex sit amet egestas tempus. Etiam vulputate, metus non dignissim rhoncus, nibh ",
                    likeNumber: 999,
                    commentNumber: 224,
                    profileOnTap: () {},
                    likeOnTap: () {},
                    commentOnTap: () {},
                  ),
                  Postwidget(
                    profileName: "Thiago",
                    postTime: DateTime.now(),
                    postText:
                        "Musica Nova Lançada! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin elementum bibendum risus nec lacinia. In hac habitasse platea dictumst. Mauris eget mi non ligula fringilla sodales non ac augue. Quisque vel consectetur odio. Vivamus scelerisque ex sit amet egestas tempus. Etiam vulputate, metus non dignissim rhoncus, nibh ",
                    likeNumber: 999,
                    commentNumber: 224,
                    profileOnTap: () {},
                    likeOnTap: () {},
                    commentOnTap: () {},
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
