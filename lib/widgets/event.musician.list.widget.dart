import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class EventMusicianListWidget extends StatelessWidget {
  const EventMusicianListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Image.asset(
                "assets/person.png",
                width: 45,
              ),
              Text('Thiago Marques'),
            ],
          ),
          IconButton(
            iconSize: 30,
            color: AppColors.textLight,
            onPressed: () {
              print("Apertado");
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
