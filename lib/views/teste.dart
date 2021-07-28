import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:places_service/places_service.dart';
import 'package:tcc_bora_show/core/app.credentials.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  List<String> cidades = ["nw", "mf", "fg"];

  Future<List<String>> _suggestionsLocation(String location) async {
    String local = location;

    final _placeService = PlacesService();
    _placeService.initialize(apiKey: PLACES_API_KEY);
    final placesResust = await _placeService.getAutoComplete(local);
    placesResust.forEach((data) {
      print(data.toJson());
    });

    return cidades;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
      body: TypeAheadField(
        suggestionsCallback: _suggestionsLocation,
        itemBuilder: (context, String item) {
          return Text(item);
        },
        onSuggestionSelected: (String item) {},
      ),
    );
  }
}
