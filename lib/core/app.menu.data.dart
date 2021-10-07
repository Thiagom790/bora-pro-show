import 'package:flutter/material.dart';
import 'package:tcc_bora_show/views/event.management.dart';
import 'package:tcc_bora_show/views/events.view.dart';
import 'package:tcc_bora_show/views/home.view.dart';
import 'package:tcc_bora_show/views/profile.view.dart';

final menuData = {
  "user": [
    {
      "title": "Home",
      "page": Home(),
      "icon": Icon(Icons.home),
    },
    {
      "title": "Shows",
      "page": EventsView(),
      "icon": Icon(Icons.location_on),
    },
    {
      "title": "Perfil",
      "page": ProfileView(),
      "icon": Icon(Icons.person),
    },
  ],
  "organizer": [
    {
      "title": "Home",
      "page": Container(child: Text('Shows')),
      "icon": Icon(Icons.home),
    },
    {
      "title": "Shows",
      "page": Container(child: Text('Shows')),
      "icon": Icon(Icons.location_on)
    },
    {
      "title": "Gerência",
      "page": EventManagement(),
      "icon": Icon(Icons.business_center),
    },
    {
      "title": "Perfil",
      "page": ProfileView(),
      "icon": Icon(Icons.person),
    },
  ],
  "musician": [
    {
      "title": "Home",
      "page": Container(child: Text('Shows')),
      "icon": Icon(Icons.home),
    },
    {
      "title": "Shows",
      "page": Container(child: Text('Shows')),
      "icon": Icon(Icons.location_on)
    },
    {
      "title": "Gerência",
      "page": Container(child: Text('Gerência')),
      "icon": Icon(Icons.business_center)
    },
    {
      "title": "Perfil",
      "page": ProfileView(),
      "icon": Icon(Icons.person),
    },
  ],
};
