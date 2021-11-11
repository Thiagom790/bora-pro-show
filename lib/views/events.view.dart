import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/event.viewmodel.dart';
import 'package:tcc_bora_show/views/event.detail.visitant.view.dart';

class EventsView extends StatefulWidget {
  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  Completer<GoogleMapController> _controller = Completer();
  final _eventController = EventController();
  late ProfileStore _profileStore;
  Set<Marker> _markersList = {};

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
    googleMapController.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#242f3e"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#746855"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#242f3e"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#263c3f"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#6b9a76"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#38414e"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#212a37"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#9ca5b3"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#746855"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#1f2835"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#f3d19c"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#2f3948"}]},{"featureType":"transit.station","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#17263c"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#515c6d"}]},{"featureType":"water","elementType":"labels.text.stroke","stylers":[{"color":"#17263c"}]}]');
  }

  CameraPosition _posicaoCamera =
      CameraPosition(target: LatLng(-0, -0), zoom: 13);

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_posicaoCamera));
  }

  _recuperarLocalizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _posicaoCamera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17,
      );
      _movimentarCamera();
    });
  }

  _loadMarkers() async {
    try {
      final profileRole = this._profileStore.role;
      List<EventViewModel> eventList = [];

      if (profileRole == 'musician') {
        eventList = await _eventController.selectEventsMusicianMap();
      } else {
        eventList = await _eventController.selectAllEventsVisitant();
      }

      final Set<Marker> markerList = {};

      eventList.forEach((event) {
        var marker = Marker(
          markerId: MarkerId(event.id),
          position: LatLng(event.latitude, event.longitude),
          infoWindow: InfoWindow(title: event.title),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailVisitantView(
                  eventID: event.id,
                ),
              ),
            );
          },
        );

        markerList.add(marker);
      });

      setState(() {
        _markersList = markerList;
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro!"),
            content: Text(error.toString()),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._profileStore = Provider.of<ProfileStore>(context);
    _recuperarLocalizacaoAtual();
    _loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition: _posicaoCamera,
        markers: this._markersList,
      ),
    );
  }
}
