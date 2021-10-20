import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class EventMusicianListWidget extends StatelessWidget {
  final double fontSize;
  final void Function() onPressed;
  final IconData icon;
  final String title;

  const EventMusicianListWidget({
    required this.onPressed,
    required this.title,
    required this.icon,
    this.fontSize = 15,
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
              Text(
                this.title,
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: this.fontSize,
                ),
              ),
            ],
          ),
          IconButton(
            iconSize: 30,
            color: AppColors.textLight,
            onPressed: this.onPressed,
            icon: Icon(this.icon),
          )
        ],
      ),
    );
  }
}
