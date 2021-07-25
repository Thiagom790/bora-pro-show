import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/models/user.model.dart';
import 'package:tcc_bora_show/repositories/auth.repository.dart';
import 'package:tcc_bora_show/repositories/profile.repository.dart';
import 'package:tcc_bora_show/repositories/user.repository.dart';
import 'package:tcc_bora_show/view-models/auth.viewmodel.dart';
import 'package:tcc_bora_show/view-models/user.viewmodel.dart';

class AuthController {
  late AuthRepository _authRepository;
  late UserRepository _userRepository;
  late ProfileRepository _profileRepository;

  AuthController() {
    _authRepository = AuthRepository();
    _userRepository = UserRepository();
    _profileRepository = ProfileRepository();
  }

  bool userIsAuth() {
    return _authRepository.isAuth();
  }

  Future<UserViewModel> login(AuthViewModel model) async {
    model.busy = true;
    final email = model.email;
    final password = model.senha;

    try {
      String userId = await _authRepository.login(
        email: email,
        password: password,
      );

      bool isAuth = userIsAuth();

      return new UserViewModel(
        uid: userId,
        isAuth: isAuth,
      );
    } catch (e) {
      throw e;
    } finally {
      model.busy = false;
    }
  }

  Future<UserViewModel> register(AuthViewModel model) async {
    model.busy = true;
    final email = model.email;
    final senha = model.senha;
    final name = model.name;
    final role = "user";

    try {
      // create user crendentials
      final userUID = await _authRepository.createCredential(
        email: email,
        password: senha,
      );

      // create your firts profile
      final profile = ProfileModel(
        name: name,
        userUid: userUID,
        role: role,
      );

      final profileID = await _profileRepository.create(profile);

      //create user in firestore
      final user = UserModel(
        email: email,
        currentUidProfile: profileID,
        role: role,
        uid: userUID,
      );
      await _userRepository.create(user);

      return new UserViewModel(
        currentUidProfile: profileID,
        isAuth: true,
        role: role,
        uid: userUID,
      );
    } catch (e) {
      throw e;
    } finally {
      model.busy = false;
    }
  }
}
