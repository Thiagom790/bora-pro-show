import 'package:tcc_bora_show/models/event.model.dart';

class EventDetailViewModel extends EventModel {
  String organizerName = "";
  bool isConfirmed = false;

  EventDetailViewModel();

  EventDetailViewModel.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    this.organizerName = map['organizerName'];
    if (map.containsKey('isConfirmed')) {
      this.isConfirmed = map['isConfirmed'];
    }
  }
}
