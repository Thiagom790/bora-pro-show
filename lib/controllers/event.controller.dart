import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/repositories/event.repository.dart';
import 'package:tcc_bora_show/view-models/event.viewmodel.dart';

class EventController {
  late EventRepository _repository;

  EventController() {
    _repository = new EventRepository();
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

  Future<List<EventViewModel>> selectAllEvents() async {
    try {
      return await this._repository.selectAllEvents();
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
}
