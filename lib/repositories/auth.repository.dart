import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _reference = FirebaseAuth.instance;

  Future<String> uidUserAuth() async {
    String userUid = "";
    var user = await _reference.currentUser;

    if (user != null) {
      userUid = user.uid;
    }

    return userUid;
  }

  Future<String> createCredential({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credentials = await _reference
          .createUserWithEmailAndPassword(email: email, password: password);
      return credentials.user!.uid;
    } catch (e) {
      throw e;
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await _reference.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.user!.uid;
    } catch (e) {
      throw e;
    }
  }

  bool isAuth() {
    bool returnValue = false;
    var user = _reference.currentUser;
    if (user != null) {
      returnValue = true;
    }
    return returnValue;
  }
}
