class ProfileViewModel {
  String id = "";
  String name = "";
  String role = "";

  ProfileViewModel({this.name = "", this.id = "", this.role = ""});

  ProfileViewModel.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.role = map["role"];
  }
}
