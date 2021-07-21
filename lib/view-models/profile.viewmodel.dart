class ProfileViewModel {
  String id = "";
  String name = "";

  ProfileViewModel({this.name = "", this.id = ""});

  ProfileViewModel.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
  }
}
