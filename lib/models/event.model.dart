class EventModel {
  late String idProfile;
  late String id;
  late String title;
  late String genre;
  late String description;
  //   Corrigir para timestan
  late String date;
  late String time;
  late double latitude;
  late double longitude;
  late String address;
//   Corrigir quentão do numero
  late String status;

  EventModel({
    this.idProfile = "",
    this.title = "",
    this.genre = "",
    this.date = "",
    this.time = "",
    this.latitude = 0,
    this.longitude = 0,
    this.address = "",
    this.description = "",
    this.status = "",
    this.id = "",
  });

  EventModel.fromMap(Map<String, dynamic> data) {
    this.idProfile = data['idProfile'];
    this.title = data['title'];
    this.genre = data['genre'];
    this.date = data['date'];
    this.time = data['time'];
    this.latitude = data['latitude'];
    this.longitude = data['longitude'];
    this.address = data['address'];
    this.description = data['description'];
    this.id = data['id'];
    this.status = data['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      "idProfile": this.idProfile,
      "title": this.title,
      "genre": this.genre,
      "date": this.date,
      "time": this.time,
      "latitude": this.latitude,
      "longitude": this.longitude,
      "address": this.address,
      "description": this.description,
      "status": this.status,
    };
  }
}
