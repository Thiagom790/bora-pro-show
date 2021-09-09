class ProfileModel {
  late String id;
  late String userUid;
  late String name;
  late String role;
  late String city;
  late String phoneNumber;
  late List<String> musicGenre;
  late double rating;

  ProfileModel({
    this.name = '',
    this.userUid = '',
    this.role = '',
    this.id = "",
    this.city = "",
    this.musicGenre = const [],
    this.rating = 0,
    this.phoneNumber = "",
  });

  ProfileModel.fromMap(Map<String, dynamic> map) {
    List<String> musicGenre = new List<String>.from(map['musicGenre']);

    this.id = map["id"];
    this.userUid = map["userUid"];
    this.name = map["name"];
    this.role = map["role"];
    this.city = map["city"];
    this.phoneNumber = map["phoneNumber"];
    this.musicGenre = musicGenre;
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
