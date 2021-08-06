import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tcc_bora_show/controllers/location.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/address.model.dart';
import 'package:tcc_bora_show/models/event.model.dart';

class EventAddressWidget extends StatelessWidget {
  final _controllerAddress = TextEditingController();
  final _locationController = LocationController();
  final EventModel model;

  EventAddressWidget({
    required this.model,
    Key? key,
  }) : super(key: key);

  void _buildControllers() {
    _controllerAddress.text = model.address;
  }

  Future<List<AddressModel>> _getSuggestion(String location) async {
    final lista = await _locationController.locationSuggestion(location);

    return lista;
  }

  Widget _builderSugestion(BuildContext context, AddressModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      color: AppColors.container,
      child: Text(
        '${model.description}',
        style: TextStyle(fontSize: 15, color: AppColors.textLight),
      ),
    );
  }

  void _onSuggestionSelected(AddressModel model) {
    if (model.id == null) {
      return;
    }

    this.model.address = model.description;
    this.model.locationID = model.id!;
    _controllerAddress.text = model.description;
  }

  @override
  Widget build(BuildContext context) {
    _buildControllers();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          TypeAheadField<AddressModel>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: this._controllerAddress,
              style: TextStyle(fontSize: 20, color: AppColors.textLight),
              decoration: InputDecoration(
                hintText: "Endereço",
                hintStyle: TextStyle(color: AppColors.textLight),
                filled: true,
                fillColor: AppColors.container,
                contentPadding: EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            suggestionsCallback: this._getSuggestion,
            itemBuilder: this._builderSugestion,
            onSuggestionSelected: this._onSuggestionSelected,
          ),
        ],
      ),
    );
  }
}
