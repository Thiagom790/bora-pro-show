import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/repositories/auth.repository.dart';
import 'package:tcc_bora_show/repositories/profile.repository.dart';
import 'package:tcc_bora_show/repositories/user.repository.dart';
import 'package:tcc_bora_show/view-models/profile.viewmodel.dart';

class ProfileController {
  late ProfileRepository _profileRepository;
  late UserRepository _userRepository;
  late AuthRepository _authRepository;

  ProfileController() {
    _profileRepository = ProfileRepository();
    _userRepository = UserRepository();
    _authRepository = AuthRepository();
  }

  Future<ProfileModel> changeCurrentUserProfile({
    required String profileId,
  }) async {
    try {
      String userID = await _authRepository.uidUserAuth();
      await _userRepository.setCurrentUserProfile(
        userID: userID,
        profileID: profileId,
      );

      ProfileModel profile = await _profileRepository.select(profileId);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  Future<ProfileModel> createProfile(ProfileModel model) async {
    try {
      String profileID = await _profileRepository.create(model);
      await _userRepository.setCurrentUserProfile(
        userID: model.userUid,
        profileID: profileID,
      );
      ProfileModel profile = await _profileRepository.select(profileID);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ProfileViewModel>> getUserProfiles() async {
    String userId = await _authRepository.uidUserAuth();
    return await _profileRepository.selectUserProfiles(userId);
  }

  Future<ProfileModel> currentProfile() async {
    try {
      String userID = await _authRepository.uidUserAuth();
      String idProfile = await _userRepository.getCurrentProfile(userID);
      ProfileModel profile = await _profileRepository.select(idProfile);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  List<Map<String, dynamic>> selectProfileRoles() {
    return _profileRepository.selectProfileRoles();
  }

  Future<ProfileModel> selectProfile(idProfile) async {
    try{
      return await _profileRepository.select(idProfile);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {

    try{

      await _profileRepository.updateProfile(profile);

    }catch(e) {
      throw e;
    }
  }


}
