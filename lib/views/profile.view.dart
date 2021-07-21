import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/profile.viewmodel.dart';
import 'package:tcc_bora_show/views/create.profile.view.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/profile.popupmenu.widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _controller = ProfileController();
  late ProfileStore _store;
  late ProfileViewModel _defaultProfile;
  late ReactionDisposer _disposer;
  List<ProfileViewModel> _profiles = [];
  bool _isLoading = true;

  Future<void> _getUserProfiles() async {
    try {
      var profiles = await _controller.getUserProfiles();
      var profileID = this._store.id;
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

  void _createNewProfile() {
    // print("Foi chamado criação de perfil dentro profileview");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateProfileView()),
    );
  }

  void _onSelectProfile(ProfileViewModel profile) {
    print("Print de dentro de profileview " + profile.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this._store = Provider.of<ProfileStore>(context);
    this._disposer = reaction((_) => this._store.id, (idProfile) {
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
    return _isLoading
        ? LoadingWidget()
        : Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ProfilePopupMenuWidget(
                        profiles: this._profiles,
                        defaultProfile: this._defaultProfile,
                        onSelect: this._onSelectProfile,
                        onCreateProfile: this._createNewProfile,
                      ),
                      Text(
                        "Icone",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Image.asset("assets/logo.png"),
              ],
            ),
          );
  }
}
