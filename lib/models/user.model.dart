class UserModel {
  late String uid;
  late String email;
  late String currentUidProfile;

  UserModel({
    this.uid = '',
    this.email = '',
    this.currentUidProfile = '',
  });

  UserModel.fromMap(Map<String, dynamic> json) {
    this.uid = json["uid"];
    this.email = json["email"];
    this.currentUidProfile = json["currentUidProfile"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid,
      "email": this.email,
      "currentUidProfile": this.currentUidProfile,
    };
  }
}
