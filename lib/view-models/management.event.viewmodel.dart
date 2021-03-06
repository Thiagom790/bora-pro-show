import 'package:tcc_bora_show/models/event.model.dart';

class ManagementEventViewModel extends EventModel {
  bool isCancelled = false;
  bool isConfirmed = false;
  bool isInvited = false;

  ManagementEventViewModel();

  ManagementEventViewModel.fromMap(Map<String, dynamic> map)
      : super.fromMap(map) {
    this.isCancelled = map["isCancelled"] ?? false;
    this.isConfirmed = map["isConfirmed"] ?? false;
    this.isInvited = map["isInvited"] ?? false;
  }
}
