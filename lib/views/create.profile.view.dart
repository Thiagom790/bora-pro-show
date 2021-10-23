import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:tcc_bora_show/widgets/selectbox.widget.dart';

class CreateProfileView extends StatefulWidget {
  @override
  _CreateProfileViewState createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  late List<Map<String, dynamic>> _listEventGenre = [];
  final List<String> _selectedEventGenre = [];

  final _controllerMusicGenre = TextEditingController();

  final ProfileController _controller = ProfileController();
  final _controllerEvent = EventController();
  late ProfileStore _store;
  late List<Map<String, dynamic>> _listRoles;
  ProfileModel _model = ProfileModel();
  bool _isBusy = false;
  String _erroMessage = "";
  String _selectBoxText = "Selecione um Perfil";

  bool _validateFields() {
    String erroMessage = "";
    bool returnValue = true;

    if (_controllerPhoneNumber.text.trim().isEmpty) {
      erroMessage = "Preencha o número de telefone!";
    }

    if (_controllerPhoneNumber.text.trim().isEmpty) {
      erroMessage = "Preencha a Cidade!";
    }

    if (_controllerName.text.trim().isEmpty) {
      erroMessage = "Preencha o Nome";
    } else if (_model.role.trim().isEmpty) {
      erroMessage = "Selecione um tipo de perfil válido";
    }

    if (erroMessage.isNotEmpty) {
      returnValue = false;
    }

    setState(() {
      this._erroMessage = erroMessage;
    });

    return returnValue;
  }

  void _createProfile() {
    if (!this._validateFields()) {
      return;
    }

    setState(() {
      _isBusy = true;
    });

    _model.name = _controllerName.text;
    _model.userUid = _store.userUid;
    _model.phoneNumber = _controllerPhoneNumber.text;
    _model.city = _controllerCity.text;

    this._controller.createProfile(_model).then((data) {
      _store.setProfile(
        userUid: data.userUid,
        role: data.role,
        name: data.name,
        id: data.id,
      );

      Navigator.pop(context);
    }).catchError((error) {
      setState(() {
        _erroMessage = error.message;
        _isBusy = false;
      });
    });
  }

  void _onChangeSelectBox(Map<String, dynamic>? roleInfo) {
    if (roleInfo != null) {
      this._model.role = roleInfo['id'];
      setState(() {
        this._selectBoxText = roleInfo["value"];
      });
    }
  }

  List<Map<String, dynamic>> _getEventGenres() {
    final listGenres = _controllerEvent.selectEventGenres();

    List<Map<String, dynamic>> listFormateGenres = [];
    listGenres.forEach((genre) {
      listFormateGenres.add({"value": genre, "isActive": false});
    });

    return listFormateGenres;
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
                  onPressed: () {
                    this._controllerMusicGenre.text = _selectedEventGenre.fold(
                        "", (prev, curr) => '$prev #$curr');
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
    _listRoles = _controller.selectProfileRoles();
  }

  @override
  void initState() {
    _listEventGenre = this._getEventGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criação de Perfil'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset("assets/logo2.png"),
              ),
              InputWidget(
                controller: _controllerName,
                placeholder: "Nome",
              ),
              SelectBoxWidget(
                displayText: this._selectBoxText,
                listData: this._listRoles,
                onChange: this._onChangeSelectBox,
              ),
              InputWidget(
                placeholder: "Nº Celular",
                controller: _controllerPhoneNumber,
              ),
              InputWidget(
                placeholder: "Cidade",
                controller: _controllerCity,
              ),
              if (this._selectBoxText == "músico")
                InputWidget(
                  placeholder: "Genero Musical",
                  readOnly: true,
                  controller: this._controllerMusicGenre,
                  onTap: this._onTapSelectGenre,
                ),
              LargeButtonWidget(
                onPress: this._createProfile,
                title: "Criar Perfil",
                isBusy: this._isBusy,
              ),
              Text(
                this._erroMessage,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
