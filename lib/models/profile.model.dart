class ProfileModel {
  late String id;
  late String userUid;
  late String name;
  late String role;
  late String city;
  late String phoneNumber;
  List<String>? musicGenre;
  double? rating;

  ProfileModel({
    this.name = '',
    this.userUid = '',
    this.role = '',
    this.id = "",
    this.city = "",
    this.musicGenre,
    this.rating,
    this.phoneNumber = "",
  });

  ProfileModel.fromMap(Map<String, dynamic> map) {
    this.userUid = map["userUid"];
    this.role = map["role"];
    this.name = map["name"];
    this.id = map["id"];
    this.city = map["city"];
    this.musicGenre = map["musicGenre"];
    this.rating = map["rating"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userUid": this.userUid,
      "role": this.role,
      "name": this.name,
      "id": this.id,
      "phoneNumber": this.phoneNumber,
      "city": this.city,
      "musicGenre": this.musicGenre,
      "rating": this.rating,
    };
  }
}
