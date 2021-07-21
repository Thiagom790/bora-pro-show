import 'package:mobx/mobx.dart';
part 'auth.store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  bool isAuth = false;

  @action
  void changeAuth({required bool userIsAuth}) {
    isAuth = userIsAuth;
  }
}
