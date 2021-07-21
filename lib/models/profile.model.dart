class ProfileModel {
  late String userUid;
  late String role;
  late String name;
  late String id;

  ProfileModel({
    this.name = '',
    this.userUid = '',
    this.role = '',
    this.id = "",
  });

  ProfileModel.fromMap(Map<String, dynamic> map) {
    this.userUid = map["userUid"];
    this.role = map["role"];
    this.name = map["name"];
    this.id = map["id"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userUid": this.userUid,
      "role": this.role,
      "name": this.name,
      "id": this.id,
    };
  }
}
