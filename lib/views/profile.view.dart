import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/auth.controller.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/store/auth.store.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/profile.viewmodel.dart';
import 'package:tcc_bora_show/views/create.profile.view.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/profile.popupmenu.widget.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _controller = ProfileController();
  final _authController = AuthController();
  late ProfileModel profileModel = new ProfileModel();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _phoneNumberController = TextEditingController();
  late TextEditingController _cityController = TextEditingController();
  late ProfileStore _profileStore;
  late AuthStore _authStore;
  late ProfileViewModel _defaultProfile;
  late ReactionDisposer _disposer;
  List<ProfileViewModel> _profiles = [];
  bool _isLoading = true;

  late List<Map<String, dynamic>> _listEventGenre = [];
  List<String> _selectedEventGenre = [];
  final _controllerMusicGenre = TextEditingController();
  ProfileModel _model = ProfileModel();
  final _controllerEvent = EventController();

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

  void _createNewProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateProfileView()),
    );
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

  void _selectProfile() async {

    profileModel = await _controller.selectProfile(_profileStore.id);
    this._phoneNumberController.text = this.profileModel.phoneNumber;
    this._cityController.text = this.profileModel.city;
    this._nameController.text = this.profileModel.name;
    setState(() {
      this._selectedEventGenre = this.profileModel.musicGenre;
    });


  }

  void _logout() {
    _authController.logout().then((_) {
      this._authStore.changeAuth(userIsAuth: false);
    }).catchError((error) {
      print("Erro dentro de profile view na logout" + error.toString());
    });
  }

  void _onTapSelectGenre() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Generos Musicais"),
              content: Container(
                width: 300,
                height: 300,
                child: ListView.builder(
                  itemCount: this._listEventGenre.length,
                  itemBuilder: (context, index) {
                    final item = _listEventGenre[index];
                    return CheckboxListTile(
                      title: Text(item["value"]),
                      value: item["isActive"],
                      onChanged: (value) {
                        setState(() {
                          item["isActive"] = value;
                          value!
                              ? _selectedEventGenre.add(item["value"])
                              : _selectedEventGenre.remove(item["value"]);
                        });
                        this._model.musicGenre = _selectedEventGenre;
                      },
                    );
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                  child: Text('Concluir'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> _getEventGenres() {
    final listGenres = _controllerEvent.selectEventGenres();

    List<Map<String, dynamic>> listFormateGenres = [];
    listGenres.forEach((genre) {
      listFormateGenres.add({"value": genre, "isActive": false});
    });

    return listFormateGenres;
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
  void dispose() {
    this._disposer();
    super.dispose();
  }

  @override
  void initState() {
    _listEventGenre = this._getEventGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingWidget()
        : SingleChildScrollView(
            child: Container(
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
                  Container(

                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("assets/tiaguinho.jpg"),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.red,
                    ),
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.container,
                      shape: BoxShape.circle,
                    ),
                  ),
                  //Image.asset("assets/logo.png"),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.container,
                                padding: EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        topLeft: Radius.circular(15))),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Informações",
                                style: TextStyle(color: AppColors.textLight),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.container,
                              padding: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                            ),
                            child: Text(
                              "Seguidores",
                              style: TextStyle(
                                color: AppColors.textLight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Text(this._profileStore.role),
                  InputWidget(
                    placeholder: "Nome",
                    controller: _nameController,
                  ),
                  InputWidget(
                    placeholder: "Nº Celular",
                    controller: _phoneNumberController,
                  ),
                  InputWidget(
                    placeholder: "Cidade",
                    controller: _cityController,
                  ),
                  if (this._profileStore.role == "musician")
                    InputWidget(
                      placeholder: "Genero Musical",
                      readOnly: true,
                      controller: this._controllerMusicGenre,
                      onTap: this._onTapSelectGenre,
                    ),
                  LargeButtonWidget(
                      title: "Salvar Mudanças",
                      onPress: (){
                        ProfileModel _profile = new ProfileModel();
                        _profile.id = profileModel.id;
                        _profile.name = _nameController.text;
                        _profile.city = _cityController.text;
                        _profile.phoneNumber = _phoneNumberController.text;
                        _profile.role = profileModel.role;
                        _profile.rating = profileModel.rating;
                        _profile.userUid = profileModel.userUid;
                        _profile.musicGenre = profileModel.musicGenre;
                        try{
                          _controller.updateProfile(_profile);
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: new Text("Sucesso!"),
                                  content: new Text("Mudanças Salvas com sucesso."),
                                  actions: <Widget> [
                                    new TextButton(
                                        child: new Text("Fechar"),
                                        onPressed: (){Navigator.of(context).pop();}
                                    ),
                                  ],
                                );
                              }
                          );

                        }catch (e){
                          throw e;
                        }
                      }
                  ),
                ],
              ),
            ),
          );
  }
}
