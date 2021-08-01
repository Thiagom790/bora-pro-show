import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/repositories/event.repository.dart';

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
}
