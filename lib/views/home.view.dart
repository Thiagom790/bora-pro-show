import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/widgets/musician.searchbar.widget.dart';
import 'package:tcc_bora_show/widgets/post.widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MusicianSearchBar(
            onPressed: () {},
          ),
          Postwidget(
            profileName: "Thiago",
            postTime: DateTime.now(),
            postText: "Teste123",
            likeNumber: 999,
            commentNumber: 224,
            profileOnTap: (){},
            likeOnTap: (){},
            commentOnTap: (){},
          ),
          Postwidget(
            profileName: "Guilherme",
            postTime: DateTime.now(),
            postText: "Texto bonito aaaa",
            likeNumber: 888,
            commentNumber: 333,
            profileOnTap: (){},
            commentOnTap: (){},
            likeOnTap: (){},
          ),
          /*Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 25, 4),
            child: Row(
              children: <Widget>[
                Icon(Icons.person, color: AppColors.textLight, size: 38),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Guilherme Henrique",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "13 mar. 2021",
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textLowOppacity,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 25, 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.container,
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sagittis euismod odio in consectetur. Aenean mollis suscipit magna a rhoncus. Donec suscipit blandit nisl quis porta. Donec scelerisque nisl at velit convallis condimentum. Donec accumsan turpis ullamcorper orci maximus bibendum. Sed rhoncus commodo ligula id commodo. Mauris nec tellus nibh. Curabitur sollicitudin ornare ipsum. Pellentesque auctor lorem eget aliquet dignissim. Nulla ultricies varius ultricies. Donec sapien massa, convallis a urna ut, molestie euismod justo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec ultrices, eros non dapibus accumsan, sem diam hendrerit tellus, ac condimentum nunc massa sit amet mauris. Morbi a quam sed tortor elementum porta.",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 25, 8),
            child: Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/rock-and-roll-white.png",
                        width: 35,
                        height: 30,
                      ),
                      Text(
                        "999",
                        style: TextStyle(color: AppColors.textLight),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.comment,
                          color: AppColors.textLight,
                        ),
                      ),
                      Text(
                        "324",
                        style: TextStyle(color: AppColors.textLight),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
