import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/user.model.dart';

class UserRepository {
  final _reference = FirebaseFirestore.instance.collection("users");

  Future<String> getCurrentProfile(String userID) async {
    try {
      final snapshot = await _reference.doc(userID).get();
      final userMap = snapshot.data();
      return userMap!["currentUidProfile"];
    } catch (e) {
      throw e;
    }
  }

  Future<void> setCurrentUserProfile({
    required String userID,
    required String profileID,
  }) async {
    try {
      await _reference.doc(userID).update({"currentUidProfile": profileID});
    } catch (e) {
      throw e;
    }
  }

  Future<String> create(UserModel model) async {
    try {
      await _reference.doc(model.uid).set(model.toMap());
      return model.uid;
    } catch (e) {
      throw e;
    }
  }
}
