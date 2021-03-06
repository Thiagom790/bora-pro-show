import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/models/event.musician.model.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/repositories/event.repository.dart';
import 'package:tcc_bora_show/repositories/profile.repository.dart';
import 'package:tcc_bora_show/view-models/event.detail.viewmodel.dart';
import 'package:tcc_bora_show/view-models/event.viewmodel.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';

class EventController {
  late EventRepository _repository;
  late ProfileRepository _repositoryProfile;

  EventController() {
    _repository = new EventRepository();
    _repositoryProfile = new ProfileRepository();
  }

  Future<List<EventMusicianModel>> updateAllEventMusicians(
      List<EventMusicianModel> musicians) async {
    return await this._repository.updateAllEventMusicians(musicians);
  }

  Future<List<EventMusicianModel>> updateEventMusicianList(
      EventMusicianModel musician) async {
    try {
      return await this._repository.updateEventMusicianList(musician);
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeEvent(String eventID) async {
    try {
      await this._repository.removeEvent(eventID);
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeEvent(EventDetailViewModel event) async {
    try {
      await _repository.changeEvent(event);
    } catch (e) {
      throw e;
    }
  }

  Future<void> subscribeEvent(EventMusicianModel model) async {
    try {
      await _repository.addMusician(model);
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeMusicianStatus(EventMusicianModel model) async {
    try {
      await _repository.changeMusicianStatus(model);
    } catch (e) {
      throw e;
    }
  }

  Future<EventDetailViewModel> selectEventDetailvisitant(String eventID) async {
    try {
      return await _repository.selectEventDetailvisitant(eventID);
    } catch (e) {
      throw e;
    }
  }

  Future<EventDetailViewModel> selectEventDetailOrganizer(
      String eventID) async {
    try {
      return await this._repository.selectEventDetailOrganizer(eventID);
    } catch (e) {
      throw e;
    }
  }

  Future<EventDetailViewModel> selectEventDetailMusician({
    required String eventId,
    required String musicianID,
  }) async {
    try {
      return await _repository.selectEventDetailMusician(
        musicianID: musicianID,
        eventID: eventId,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<List<ManagementEventViewModel>> selectEventsOrganizer(
    String organizerID, {
    String? status,
  }) async {
    try {
      if (status != null) {
        return await _repository.filterByStatusEventsOrganizer(
          organizerID: organizerID,
          status: status,
        );
      }

      return await _repository.selectEventsOrganizer(organizerID);
    } catch (e) {
      throw e;
    }
  }

  Future<List<ManagementEventViewModel>> selectMusicianEvent(
    String musicianID, {
    String? status,
  }) async {
    try {
      if (status != null) {
        return await _repository.filterByStatusEventsMusician(
          musicianID: musicianID,
          status: status,
        );
      }
      return await _repository.selectAllMusiciansEvents(musicianID);
    } catch (e) {
      throw e;
    }
  }

  Future<String> createEvent(EventModel model) async {
    try {
      return await this._repository.createEvent(model);
    } catch (e) {
      throw e;
    }
  }

  Future<EventModel> selectEvent(String eventID) async {
    try {
      return await this._repository.select(eventID);
    } catch (e) {
      throw e;
    }
  }

  Future<List<EventViewModel>> selectAllEventsVisitant() async {
    try {
      return await this._repository.selectAllEventsVisitant();
    } catch (e) {
      throw e;
    }
  }

  Future<List<EventViewModel>> selectEventsMusicianMap() async {
    try {
      return await this._repository.selectEventsMusicianMap();
    } catch (e) {
      throw e;
    }
  }

  List<Map<String, dynamic>> selectEventTypes() {
    return this._repository.selectEventTypes();
  }

  List<String> selectEventGenres() {
    return this._repository.selectEventGenres();
  }

  Future<List<ProfileModel>> selectMusiciansProfiles() async {
    try {
      return await _repositoryProfile.selectAllMusicians();
    } catch (e) {
      throw e;
    }
  }
}
