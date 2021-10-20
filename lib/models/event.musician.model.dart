class EventMusicianModel {
  String id = "";
  late String musicianID;
  late String eventID;
  late bool isConfirmed;
  late bool isCancelled;
  late bool isInvited;
  late bool isSelected;
  bool toRemove = false;
  late String name;

  EventMusicianModel({
    this.musicianID = "",
    this.isConfirmed = false,
    this.isCancelled = false,
    this.isInvited = false,
    this.eventID = "",
    this.isSelected = false,
    this.name = "",
    this.toRemove = false,
  });

  EventMusicianModel.fromMap(Map<String, dynamic> map) {
    this.musicianID = map["musicianID"];
    this.eventID = map["eventID"];
    this.isConfirmed = map["isConfirmed"];
    this.isCancelled = map["isCancelled"];
    this.isInvited = map["isInvited"];
    this.id = map['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      "musicianID": this.musicianID,
      "isConfirmed": this.isConfirmed,
      "isCancelled": this.isCancelled,
      "isInvited": this.isInvited,
      "eventID": this.eventID,
    };
  }
}
