import 'package:tcc_bora_show/models/user.model.dart';

class UserViewModel extends UserModel {
  bool isAuth = false;

  UserViewModel({
    this.isAuth = false,
    uid = '',
    role = '',
    currentUidProfile = '',
  }) : super(
          uid: uid,
          currentUidProfile: currentUidProfile,
        );
}
