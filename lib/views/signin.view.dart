import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/auth.controller.dart';
import 'package:tcc_bora_show/store/auth.store.dart';
import 'package:tcc_bora_show/view-models/auth.viewmodel.dart';
import 'package:tcc_bora_show/view-models/user.viewmodel.dart';
import 'package:tcc_bora_show/views/register.view.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';
import 'package:tcc_bora_show/views/reset.password.view.dart';

class SigninView extends StatefulWidget {
  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController _controllerEmail = TextEditingController(
    text: "thiagom790@gmail.com",
  );

  final TextEditingController _controllerSenha = TextEditingController(
    text: "Teste@123",
  );

  final AuthController _controller = AuthController();

  late AuthStore _store;

  late GoogleSignIn _googleRefs;

  final AuthViewModel _model = AuthViewModel();

  String _errorMessage = "";

  bool _validadeFields() {
    String errorMesage = "";
    bool returnValue = true;

    if (!_model.email.contains("@") || _model.email.length < 5) {
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

  void _login() {
    _model.email = _controllerEmail.text;
    _model.senha = _controllerSenha.text;

    // validate fields
    if (!_validadeFields()) {
      return;
    }

    // login user
    _controller.login(_model).then((data) {
      _store.changeAuth(userIsAuth: data.isAuth);
    }).catchError((e) {
      setState(() {
        _errorMessage = e.message;
      });
    });
  }

  Future<UserViewModel> signGoogle() async {
    try {
      final user = await this._googleRefs.signIn();
      final credentials = await _controller.siginGoogle(user);

      final authModel = AuthViewModel();
      authModel.uid = credentials.user!.uid;
      authModel.email = credentials.user!.email!;
      authModel.city = "";
      authModel.phoneNumber = "";
      authModel.name = credentials.user!.displayName!;

      return await _controller.handleGoogleAuth(authModel);
    } catch (e) {
      print("Erro: " + e.toString());
      throw e;
    }
  }

  void handleGoogleLogin() {
    signGoogle().then((data) {
      _store.changeAuth(userIsAuth: data.isAuth);
    }).catchError((error) {
      setState(() {
        _errorMessage = error.toString();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<AuthStore>(context);
    _googleRefs = _controller.getGoogleReference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset("assets/logo2.png"),
                ),
                InputWidget(
                  controller: _controllerEmail,
                  placeholder: "Email",
                  autofocus: true,
                ),
                InputWidget(
                  controller: _controllerSenha,
                  placeholder: "Senha",
                  obscure: true,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        text: "Não tem conta? ",
                        style: TextStyle(fontSize: 18),
                        children: [
                          TextSpan(
                            text: "Cadastre-se!",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterView()),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        text: "Esqueceu a senha? ",
                        style: TextStyle(fontSize: 18),
                        children: [
                          TextSpan(
                            text: "Resetar senha!",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordView()),
                      );
                    },
                  ),
                ),
                LargeButtonWidget(
                  title: "Login",
                  onPress: _login,
                  isBusy: _model.busy,
                ),
                LargeButtonWidget(
                  title: "Login Google",
                  onPress: handleGoogleLogin,
                  color: Colors.red,
                ),
                Text(
                  this._errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
