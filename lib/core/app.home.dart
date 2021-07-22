import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/profile.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/core/app.menu.data.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/views/splash.view.dart';
import 'package:tcc_bora_show/widgets/navbar.botton.widget.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final _controller = ProfileController();
  late ProfileStore _store;
  bool _isLoading = true;
  int _currentIndex = 2;

  Future<void> _handleGetProfile() async {
    try {
      var profile = await _controller.currentProfile();

      _store.setProfile(
        userUid: profile.userUid,
        role: profile.role,
        name: profile.name,
        id: profile.id,
      );

      print("Print dentro da função em HomeView: ${profile.id}");

      setState(() {
        this._isLoading = false;
      });
    } catch (e) {
      throw e;
    }
  }

  void _handleSelect(index) {
    setState(() {
      this._currentIndex = index;
    });
  }

  List<Widget> _getPage(String role) {
    List<Widget> pages = menuData[role]!
        .map<Widget>((Map<String, dynamic> pageInfo) => pageInfo["page"])
        .toList();

    return pages;
  }

  Widget get _body {
    return Observer(builder: (context) {
      String role = this._store.role;
      List<Widget> pages = this._getPage(role);

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(child: pages[this._currentIndex]),
        bottomNavigationBar: NavyBarBottonWidget(
          role: role,
          onItemSelected: this._handleSelect,
          selectIndex: this._currentIndex,
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);

    // Carregamento do Perfil
    _handleGetProfile().then((value) {
      print("Perfil carregado corretamento no widget HomeView");
    }).catchError((error) {
      print("Erro no widget HomeView ${error.message}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? SplashView() : this._body;
  }
}
