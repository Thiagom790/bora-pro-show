class UserModel {
  late String uid;
  late String email;
  late String role;
  late String currentUidProfile;

  UserModel({
    this.uid = '',
    this.email = '',
    this.role = '',
    this.currentUidProfile = '',
  });

  UserModel.fromMap(Map<String, dynamic> json) {
    this.uid = json["uid"];
    this.email = json["email"];
    this.role = json["role"];
    this.currentUidProfile = json["currentUidProfile"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid,
      "email": this.email,
      "role": this.role,
      "currentUidProfile": this.currentUidProfile,
    };
  }
}
