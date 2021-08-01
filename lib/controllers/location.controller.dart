import 'package:tcc_bora_show/models/address.model.dart';
import 'package:tcc_bora_show/repositories/location.repository.dart';

class LocationController {
  late LocationRepository _repository;

  LocationController() {
    _repository = LocationRepository();
  }

  Future<AddressModel> getAddresInfo(String addressId) async {
    return await _repository.select(addressId);
  }

  Future<List<AddressModel>> locationSuggestion(String location) async {
    return await this._repository.locationSuggestion(location);
  }
}
