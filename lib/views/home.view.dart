import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bora_show/widgets/musician.searchbar.widget.dart';
import 'package:tcc_bora_show/widgets/post.widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MusicianSearchBar(
            onPressed: () {},
            controller: controller,
          ),
          Postwidget(
            profileName: "Thiago",
            postTime: DateTime.now(),
            postText: "Teste123",
            likeNumber: 999,
            commentNumber: 224,
            profileOnTap: () {},
            likeOnTap: () {},
            commentOnTap: () {},
          ),
          Postwidget(
            profileName: "Guilherme",
            postTime: DateTime.now(),
            postText: "Texto bonito aaaa",
            likeNumber: 888,
            commentNumber: 333,
            profileOnTap: () {},
            commentOnTap: () {},
            likeOnTap: () {},
          ),
        ],
      ),
    );
  }
}
