import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/auth.controller.dart';
import 'package:tcc_bora_show/store/auth.store.dart';
import 'package:tcc_bora_show/core/app.home.dart';
import 'package:tcc_bora_show/views/signin.view.dart';

class AppAuth extends StatefulWidget {
  const AppAuth({Key? key}) : super(key: key);

  @override
  _AppAuthState createState() => _AppAuthState();
}

class _AppAuthState extends State<AppAuth> {
  final _controller = AuthController();
  late AuthStore _store;

  Widget _handleBody() {
    bool isAuth = _controller.userIsAuth();

    _store.changeAuth(userIsAuth: isAuth);

    return Observer(builder: (context) {
      return _store.isAuth ? AppHome() : SigninView();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<AuthStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return this._handleBody();
  }
}
