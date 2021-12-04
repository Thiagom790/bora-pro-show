class PostModel {
  late String id;
  late String musicianName;
  late int _dateTime;
  late String text;
  late int numLikes;
  late int numComments;
  late String pathPhoto;

  PostModel({
    this.id = "",
    this.musicianName = "",
    this.text = "",
    this.numLikes = 0,
    this.numComments = 0,
    this.pathPhoto = "",
    DateTime? dateTime,
  }) : _dateTime = dateTime != null
            ? dateTime.millisecondsSinceEpoch
            : DateTime.now().millisecondsSinceEpoch;

  DateTime get date {
    return DateTime.fromMillisecondsSinceEpoch(this._dateTime);
  }

  set date(DateTime date) {
    final hour = this.date.hour;
    final minute = this.date.minute;
    final newDate = DateTime(date.year, date.month, date.day, hour, minute);
    this._dateTime = newDate.millisecondsSinceEpoch;
  }

  PostModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.musicianName = map['musicianName'];
    this._dateTime = map['dateTime'];
    this.text = map['text'];
    this.numLikes = map['numLikes'];
    this.pathPhoto = map['pathPhoto'];
    this.numComments = map['numComments'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'musicianName': this.musicianName,
      'dateTime': this._dateTime,
      'text': this.text,
      'numLikes': this.numLikes,
      'pathPhoto': this.pathPhoto,
      'numComments': this.numComments,
    };
  }
}
