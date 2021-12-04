import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bora_show/views/musician.search.view.dart';
import 'package:tcc_bora_show/widgets/musician.searchbar.widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _openSearchProfileMusician() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MusicianSearchView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: MusicianSearchBar(
        readOnly: true,
        onPressed: _openSearchProfileMusician,
      ),
    );
  }
}
