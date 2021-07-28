import 'package:places_service/places_service.dart';
import 'package:tcc_bora_show/core/app.credentials.dart';
import 'package:tcc_bora_show/models/address.model.dart';

class LocationRepository {
  late PlacesService _service;

  LocationRepository() {
    _service = PlacesService();
    this._service.initialize(apiKey: PLACES_API_KEY);
  }

  Future<List<AddressModel>> locationSuggestion(String location) async {
    final List<AddressModel> addressList = [];
    try {
      final results = await _service.getAutoComplete(location);

      results.forEach((data) {
        var address = AddressModel(
          mainText: data.mainText!,
          description: data.description!,
          id: data.placeId,
        );

        addressList.add(address);
      });

      return addressList;
    } catch (e) {
      print("Erro detro de address repository" + e.toString());

      AddressModel emptyAddress = AddressModel(
        mainText: "Local não encontrado",
      );
      addressList.add(emptyAddress);

      return addressList;
    }
  }
}
