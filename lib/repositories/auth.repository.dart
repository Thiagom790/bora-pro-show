import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _reference = FirebaseAuth.instance;
  final _googleReference = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignIn get googleReference {
    return this._googleReference;
  }

  Future<UserCredential> signGoogle(GoogleSignInAccount? user) async {
    try {
      if (user == null) {
        throw "Usuario Nulo";
      }

      final googleAuth = await user.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _reference.signInWithCredential(credentials);
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      await _reference.signOut();
    } catch (e) {
      throw e;
    }
  }

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
