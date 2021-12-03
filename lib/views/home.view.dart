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
            postText:
            "Musica Nova Lançada! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin elementum bibendum risus nec lacinia. In hac habitasse platea dictumst. Mauris eget mi non ligula fringilla sodales non ac augue. Quisque vel consectetur odio. Vivamus scelerisque ex sit amet egestas tempus. Etiam vulputate, metus non dignissim rhoncus, nibh ",
            likeNumber: 999,
            commentNumber: 224,
            profileOnTap: () {},
            likeOnTap: () {},
            commentOnTap: () {},
          ),
          Postwidget(
            profileName: "Guilherme",
            postTime: DateTime.now(),
            postText:
            "Musica Nova Lançada! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin elementum bibendum risus nec lacinia. In hac habitasse platea dictumst. Mauris eget mi non ligula fringilla sodales non ac augue. Quisque vel consectetur odio. Vivamus scelerisque ex sit amet egestas tempus. Etiam vulputate, metus non dignissim rhoncus, nibh ",
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
