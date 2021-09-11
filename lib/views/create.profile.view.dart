import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
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
  final ProfileController _controller = ProfileController();
  late ProfileStore _store;
  late List<Map<String, dynamic>> _listRoles;
  ProfileModel _model = ProfileModel();
  bool _isBusy = false;
  String _erroMessage = "";
  String _selectBoxText = "Selecione um Perfil";

  bool _validateFields() {
    String erroMessage = "";
    bool returnValue = true;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
    _listRoles = _controller.selectProfileRoles();
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
