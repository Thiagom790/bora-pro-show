import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/view-models/event.viewmodel.dart';

class EventRepository {
  final _reference = FirebaseFirestore.instance.collection("event");
  final _referenceEventMusicians =
      FirebaseFirestore.instance.collection("eventMusicians");

  Future<String> addMusician(EventMusicianModel musician) async {
    try {
      final refs = await _referenceEventMusicians.add(musician.toMap());
      return refs.id;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addMusicians(List<EventMusicianModel> musicians) async {
    try {
      musicians.forEach(this.addMusician);
    } catch (e) {
      throw e;
    }
  }

  Future<String> createEvent(EventModel model) async {
    try {
      final refs = await _reference.add(model.toMap());
      final eventId = refs.id;

      final musicians = model.muscians.map<EventMusicianModel>((musician) {
        musician.eventID = eventId;
        return musician;
      }).toList();

      await addMusicians(musicians);
      return eventId;
    } catch (e) {
      throw e;
    }
  }

  Future<EventModel> select(String eventID) async {
    try {
      var document = await this._reference.doc(eventID).get();
      var eventMap = document.data();
      eventMap!['id'] = document.id;

      return EventModel.fromMap(eventMap);
    } catch (e) {
      throw e;
    }
  }

  Future<List<EventViewModel>> selectAllEvents() async {
    try {
      List<EventViewModel> list = [];

      final snapshots =
          await _reference.where("status", isEqualTo: "progress").get();

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

  List<Map<String, dynamic>> selectEventTypes() {
    final listEventTypes = [
      {"id": "Casamento", "value": "Casamento"},
      {"id": "Restaurante", "value": "Restaurante"},
      {"id": "Bar", "value": "Bar"},
      {"id": "Show", "value": "Show"},
    ];
    return listEventTypes;
  }

  List<String> selectEventGenres() {
    final listGenres = [
      "Axé",
      "Blues",
      "Country",
      "Eletrônica",
      "Forró",
      "Funk",
      "Gospel",
      "Hip Hop",
      "Jazz",
      "MPB",
      "Música clássica",
      "Pagode Gospel",
      "Pagode",
      "Rap",
      "Reggae",
      "Rock",
      "Samba",
      "Sertanejo",
    ];
    return listGenres;
  }
}
