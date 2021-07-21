import 'package:flutter/material.dart';
import 'package:tcc_bora_show/views/profile.view.dart';

final menuData = {
  "user": [
    {
      "title": "Home",
      "page": Container(child: Text('Home')),
      "icon": Icon(Icons.home)
    },
    {
      "title": "shows",
      "page": Container(child: Text('Shows')),
      "icon": Icon(Icons.location_on)
    },
    {"title": "Perfil", "page": ProfileView(), "icon": Icon(Icons.person)},
  ],
  "organizer": [
    {
      "title": "shows",
      "page": Container(child: Text('Shows')),
      "icon": Icon(Icons.location_on)
    },
    {
      "title": "Gerência",
      "page": Container(child: Text('Gerência')),
      "icon": Icon(Icons.business_center)
    },
    {"title": "Perfil", "page": ProfileView(), "icon": Icon(Icons.person)},
  ],
  "musician": [
    {
      "title": "shows",
      "page": Container(child: Text('Shows')),
      "icon": Icon(Icons.location_on)
    },
    {
      "title": "Gerência",
      "page": Container(child: Text('Gerência')),
      "icon": Icon(Icons.business_center)
    },
    {"title": "Perfil", "page": ProfileView(), "icon": Icon(Icons.person)},
  ],
};

final profileTypes = ["musician", "organizer", "user"];
