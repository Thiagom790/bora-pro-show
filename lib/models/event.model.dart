class EventModel {
  String idProfile;
  String id;
  String nome;
  String genre;
  String description;
  //   Corrigir para timestan
  String date;
  String time;
  double latitude;
  double longitude;
  String address;
//   Corrigir quentão do numero

  EventModel({
    required this.idProfile,
    required this.nome,
    required this.genre,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
    this.id = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "idProfile": this.idProfile,
      "nome": this.nome,
      "genre": this.genre,
      "date": this.date,
      "time": this.time,
      "latitude": this.latitude,
      "longitude": this.longitude,
      "address": this.address,
      "description": this.description,
    };
  }
}
