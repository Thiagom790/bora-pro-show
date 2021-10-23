import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/repositories/profile.repository.dart';
import 'package:tcc_bora_show/view-models/event.detail.viewmodel.dart';
import 'package:tcc_bora_show/view-models/event.viewmodel.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';

class EventRepository {
  final _reference = FirebaseFirestore.instance.collection("event");
  final _referenceEventMusicians =
      FirebaseFirestore.instance.collection("eventMusicians");
  final ProfileRepository _profileRepository = ProfileRepository();

  Future<void> changeEvent(EventDetailViewModel event) async {
    try {
      if (event.status == 'open') {
        final musicians = event.muscians;

        for (var musician in musicians) {
          await this._removeMusicianEvent(musician.id);
        }
      }

      await _reference.doc(event.id).update(event.toMap());
    } catch (e) {
      throw e;
    }
  }

  Future<EventMusicianModel> _selectEventMuscian({
    required String eventID,
    required String musicianID,
  }) async {
    try {
      final snaphots = await this
          ._referenceEventMusicians
          .where("eventID", isEqualTo: eventID)
          .where("musicianID", isEqualTo: musicianID)
          .get();

      final document = snaphots.docs[0];
      final eventMusicianMap = document.data();
      eventMusicianMap['id'] = document.id;

      final eventMusician = EventMusicianModel.fromMap(eventMusicianMap);
      return eventMusician;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _removeMusicianEvent(String eventMusicianID) async {
    try {
      await _referenceEventMusicians.doc(eventMusicianID).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeMusicianStatus(EventMusicianModel model) async {
    try {
      final eventMusician = await this._selectEventMuscian(
        eventID: model.eventID,
        musicianID: model.musicianID,
      );

      if (model.toRemove) {
        await this._removeMusicianEvent(eventMusician.id);
        return;
      }

      await this
          ._referenceEventMusicians
          .doc(eventMusician.id)
          .update(model.toMap());
    } catch (e) {
      throw e;
    }
  }

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

  selectEventDetailvisitant(String eventID) async {
    try {
      final eventDetail = await this.selectEventDetail(eventID);

      final listMusicians = await this._selectEventMusicians(eventID);

      eventDetail.muscians = listMusicians;

      return eventDetail;
    } catch (e) {
      throw e;
    }
  }

  Future<List<EventMusicianModel>> _selectEventMusicians(String eventID) async {
    try {
      List<EventMusicianModel> musicians = [];

      final snapshots = await _referenceEventMusicians
          .where("eventID", isEqualTo: eventID)
          .get();

      final documents = snapshots.docs;

      for (var document in documents) {
        final eventMusicianMap = document.data();
        eventMusicianMap['id'] = document.id;
        final eventMusician = EventMusicianModel.fromMap(eventMusicianMap);

        final musicianProfile = await this._profileRepository.select(
              eventMusician.musicianID,
            );

        eventMusician.name = musicianProfile.name;

        musicians.add(eventMusician);
      }

      return musicians;
    } catch (e) {
      throw e;
    }
  }

  selectEventDetailOrganizer(String eventID) async {
    try {
      final eventDetail = await this.selectEventDetail(eventID);
      final eventMusicians = await this._selectEventMusicians(eventID);

      eventDetail.muscians = eventMusicians;

      return eventDetail;
    } catch (e) {
      throw e;
    }
  }

  Future<EventDetailViewModel> selectEventDetailMusician({
    required String eventID,
    required String musicianID,
  }) async {
    try {
      final eventDetail = await this.selectEventDetail(eventID);

      final eventMusician = await this._selectEventMuscian(
        eventID: eventID,
        musicianID: musicianID,
      );

      eventDetail.isConfirmed = eventMusician.isConfirmed;

      return eventDetail;
    } catch (e) {
      throw e;
    }
  }

  Future<EventDetailViewModel> selectEventDetail(String eventID) async {
    try {
      final event = await this.select(eventID);
      final profile = await _profileRepository.select(event.idProfile);

      final eventMap = event.toMap();
      eventMap['organizerName'] = profile.name;

      final eventDetail = EventDetailViewModel.fromMap(eventMap);

      return eventDetail;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ManagementEventViewModel>> selectEventsOrganizer(
      String organizerID) async {
    try {
      final snapshot = await _reference
          .where(
            "idProfile",
            isEqualTo: organizerID,
          )
          .get();

      final documents = snapshot.docs;

      final events = documents.map<ManagementEventViewModel>((document) {
        final eventMap = document.data();
        eventMap['id'] = document.id;

        final event = ManagementEventViewModel.fromMap(eventMap);

        return event;
      }).toList();

      return events;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ManagementEventViewModel>> selectAllMusiciansEvents(
      String musicianID) async {
    try {
      List<ManagementEventViewModel> events = [];

      final snapshots = await _referenceEventMusicians
          .where("musicianID", isEqualTo: musicianID)
          .get();

      final documents = snapshots.docs;

      for (var document in documents) {
        final eventMusicianMap = document.data();
        final String eventId = eventMusicianMap['eventID'];

        final event = await this.select(eventId);
        final eventMap = event.toMap();

        eventMusicianMap.addAll(eventMap);

        final eventMusician =
            ManagementEventViewModel.fromMap(eventMusicianMap);

        events.add(eventMusician);
      }

      return events;
    } catch (e) {
      throw e;
    }
  }

  Future<List<EventViewModel>> selectAllEvents() async {
    try {
      List<EventViewModel> list = [];

      final snapshots = await _reference
          .where("status", isEqualTo: "open")
          .where("isOpenToPublic", isEqualTo: true)
          .get();

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
