import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/widgets/musician.searchbar.widget.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return MusicianSearchBar(
      onPressed: (){},
    );

  }
}

