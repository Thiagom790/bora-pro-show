import 'package:flutter/material.dart';

String dateFormat(DateTime date) {
  String day = date.day.toString().padLeft(2, "0");
  String month = date.month.toString().padLeft(2, "0");
  String year = date.year.toString().padLeft(2, "0");
  return "$day/$month/$year";
}

String timeFormat(TimeOfDay time) {
  String hour = time.hour.toString().padLeft(2, "0");
  String minute = time.minute.toString().padLeft(2, "0");
  return "$hour:$minute";
}

String shortMonth(int month) {
  List<String> months = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez'
  ];

  return months[--month];
}
