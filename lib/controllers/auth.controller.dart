import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  GoogleSignIn getGoogleReference() {
    return _authRepository.googleReference;
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }

  Future<UserCredential> siginGoogle(GoogleSignInAccount? user) async {
    try {
      return await _authRepository.signGoogle(user);
    } catch (e) {
      throw e;
    }
  }

  Future<UserViewModel> handleGoogleAuth(AuthViewModel model) async {
    try {
      final hasUser = await _profileRepository.hasUser(model.uid);

      if (hasUser) {
        return new UserViewModel(
          uid: model.uid,
          isAuth: true,
        );
      }

      final String name = model.name;
      final String email = model.email;
      final String phone = model.phoneNumber;
      final String role = 'user';
      final String city = '';

      // create your firts profile
      final profile = ProfileModel(
        name: name,
        userUid: model.uid,
        role: role,
        city: city,
        phoneNumber: phone,
      );

      final profileID = await _profileRepository.create(profile);

      //create user in firestore
      final user = UserModel(
        email: email,
        currentUidProfile: profileID,
        uid: model.uid,
      );
      await _userRepository.create(user);

      return new UserViewModel(
        currentUidProfile: profileID,
        isAuth: true,
        role: role,
        uid: model.uid,
      );
    } catch (e) {
      throw e;
    }
  }

  bool userIsAuth() {
    return _authRepository.isAuth();
  }

  Future<void> resetPassword (String email) async {
    try{
      await _authRepository.resetPassword(email);
    }
    catch(e){
      throw e;
    }
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
    final city = model.city;
    final phoneNumber = model.phoneNumber;
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
        city: city,
        phoneNumber: phoneNumber,
      );

      final profileID = await _profileRepository.create(profile);

      //create user in firestore
      final user = UserModel(
        email: email,
        currentUidProfile: profileID,
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
