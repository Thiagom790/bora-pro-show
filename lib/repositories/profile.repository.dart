import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/view-models/profile.viewmodel.dart';

class ProfileRepository {
  final _reference = FirebaseFirestore.instance.collection("profiles");

  Future<bool> hasUser(String uid) async {
    try {
      final user = await select(uid);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> create(ProfileModel model) async {
    try {
      final refs = await _reference.add(model.toMap());
      return refs.id;
    } catch (e) {
      throw e;
    }
  }

  Future<ProfileModel> select(String idProfile) async {
    try {
      final snapshot = await _reference.doc(idProfile).get();
      Map<String, dynamic> profileMap = snapshot.data()!;
      profileMap["id"] = idProfile;
      var profile = new ProfileModel.fromMap(profileMap);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ProfileViewModel>> selectUserProfiles(String userUID) async {
    try {
      final snapshots =
          await _reference.where("userUid", isEqualTo: userUID).get();

      List<ProfileViewModel> profiles = [];

      snapshots.docs.forEach((document) {
        var profileMap = document.data();
        profileMap["id"] = document.id;

        var profile = ProfileViewModel.fromMap(profileMap);

        profiles.add(profile);
      });

      return profiles;
    } catch (e) {
      throw e;
    }
  }

  List<Map<String, dynamic>> selectProfileRoles() {
    final listProfileRoles = [
      {"id": "musician", "value": "músico"},
      {"id": "organizer", "value": "organizador"},
      {"id": "user", "value": "visitante"},
    ];
    return listProfileRoles;
  }

  Future<List<ProfileModel>> selectAllMusicians() async {
    try {
      final snaphots =
          await _reference.where('role', isEqualTo: "musician").get();

      final List<ProfileModel> musicians = [];

      snaphots.docs.forEach((document) {
        var profileMap = document.data();
        profileMap['id'] = document.id;

        var profile = ProfileModel.fromMap(profileMap);

        musicians.add(profile);
      });

      return musicians;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {
    try {
      await _reference.doc(profile.id).update(profile.toMap());
    } catch (e) {
      throw e;
    }
  }
}
