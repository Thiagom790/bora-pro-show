import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/auth.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/store/auth.store.dart';
import 'package:tcc_bora_show/view-models/auth.viewmodel.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _controllerEmail = TextEditingController(
    text: "thiagom790@gmail.com",
  );

  final TextEditingController _controllerSenha = TextEditingController(
    text: "Teste@123",
  );

  final TextEditingController _controllerNome = TextEditingController(
    text: "Thiago M. Teixeira",
  );

  final AuthController _controller = AuthController();

  final AuthViewModel _model = AuthViewModel();

  late AuthStore _authStore;

  String _errorMessage = "";

  bool _validadeFields() {
    String errorMesage = "";
    bool returnValue = true;

    if (_model.name.isEmpty) {
      errorMesage = "Preencha o nome";
    } else if (!_model.email.contains("@") || _model.email.length < 5) {
      errorMesage = "Email preenchido de forma errada";
    } else if (_model.senha.length < 6) {
      errorMesage = "Preencha a senha com mais de 6 caracteres";
    }

    if (errorMesage.isNotEmpty) {
      returnValue = false;
    }

    setState(() {
      _errorMessage = errorMesage;
    });
    return returnValue;
  }

  void _register() {
    _model.name = _controllerNome.text;
    _model.email = _controllerEmail.text;
    _model.senha = _controllerSenha.text;

    // validate fields
    if (!_validadeFields()) {
      return;
    }

    // create user
    _controller.register(_model).then((data) {
      _authStore.changeAuth(userIsAuth: data.isAuth);
      Navigator.pop(context);
    }).catchError((error) {
      setState(() {
        _errorMessage = error.message;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: AppColors.background,
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
                controller: _controllerNome,
                placeholder: "Nome",
                autofocus: true,
              ),
              InputWidget(
                controller: _controllerEmail,
                placeholder: "Email",
              ),
              InputWidget(
                controller: _controllerSenha,
                placeholder: "Senha",
                obscure: true,
              ),
              LargeButtonWidget(
                title: "Cadastrar",
                onPress: _register,
                isBusy: _model.busy,
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
