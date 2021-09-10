import 'package:flutter/material.dart';

class EventModel {
  late String id;
  late String idProfile;
  late String title;
  late String address;
  late int _dateTime;
  late String pictureLink;
  late String description;
  late String type;
  late List<String> musicGenre;
  late double latitude;
  late double longitude;
  late bool isOpenToPublic;
  late String status;
  late double rating;
  String locationID = "";

  DateTime get date {
    return DateTime.fromMillisecondsSinceEpoch(this._dateTime);
  }

  set date(DateTime date) {
    final hour = this.date.hour;
    final minute = this.date.minute;
    final newDate = DateTime(date.year, date.month, date.day, hour, minute);
    this._dateTime = newDate.millisecondsSinceEpoch;
  }

  TimeOfDay get time {
    return TimeOfDay.fromDateTime(date);
  }

  set time(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    final newDate = DateTime(date.year, date.month, date.day, hour, minute);
    this._dateTime = newDate.millisecondsSinceEpoch;
  }

  EventModel({
    this.id = "",
    this.idProfile = "",
    this.title = "",
    this.address = "",
    this.pictureLink = "",
    this.description = "",
    this.type = "",
    this.musicGenre = const [],
    this.latitude = 0,
    this.longitude = 0,
    this.isOpenToPublic = true,
    this.status = "",
    this.rating = 0,
    DateTime? dateTime,
  }) : _dateTime = dateTime != null
            ? dateTime.millisecondsSinceEpoch
            : DateTime.now().millisecondsSinceEpoch;

  EventModel.fromMap(Map<String, dynamic> data) {
    this.id = data['id'];
    this.idProfile = data['idProfile'];
    this.title = data['title'];
    this.address = data['address'];
    this.pictureLink = data['pictureLink'];
    this.description = data['description'];
    this.type = data['type'];
    this.musicGenre = data['musicGenre'];
    this.latitude = data['latitude'];
    this.longitude = data['longitude'];
    this.isOpenToPublic = data['isOpenToPublic'];
    this.status = data['status'];
    this.rating = data['rating'];
    this._dateTime = data['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "idProfile": this.idProfile,
      "title": this.title,
      "address": this.address,
      "pictureLink": this.pictureLink,
      "description": this.description,
      "type": this.type,
      "musicGenre": this.musicGenre,
      "latitude": this.latitude,
      "longitude": this.longitude,
      "isOpenToPublic": this.isOpenToPublic,
      "status": this.status,
      "rating": this.rating,
      "dateTime": this._dateTime,
    };
  }
}
