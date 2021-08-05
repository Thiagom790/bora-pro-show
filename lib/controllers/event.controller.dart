import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/repositories/event.repository.dart';
import 'package:tcc_bora_show/view-models/event.viewmodel.dart';

class EventControlle {
  late EventRepository _repository;

  EventControlle() {
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
}
