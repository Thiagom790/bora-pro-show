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
  String number;

  EventModel({
    required this.idProfile,
    required this.nome,
    required this.genre,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.number,
    required this.description,
    this.id = "",
  });
}
