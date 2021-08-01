import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/event.model.dart';

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
}
