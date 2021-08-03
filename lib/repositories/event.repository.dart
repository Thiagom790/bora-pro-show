import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/view-models/event.viewmodel.dart';

class EventRepository {
  final _reference = FirebaseFirestore.instance.collection("event");

  Future<String> createEvent(EventModel model) async {
    try {
      final refs = await _reference.add(model.toMap());
      return refs.id;
    } catch (e) {
      throw e;
    }
  }

  Future<List<EventViewModel>> selectAllEvents() async {
    try{
      List<EventViewModel> list = [];

      final snapshots = await _reference.get();

      snapshots.docs.forEach((document) {
        var eventMap = document.data();
        eventMap['id'] = document.id;
        var event = EventViewModel.fromMap(eventMap);
        list.add(event);
      });

      return list;
    } catch (e) {
      throw e;
    }
  }
}
