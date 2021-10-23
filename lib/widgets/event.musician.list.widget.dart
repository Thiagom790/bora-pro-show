import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class EventMusicianListWidget extends StatelessWidget {
  final double fontSize;
  final void Function()? onPressed;
  final IconData? icon;
  final String title;
  final Color? color;
  final List<Map<String, dynamic>> actions;

  const EventMusicianListWidget({
    this.onPressed,
    required this.title,
    this.icon,
    this.fontSize = 15,
    this.color,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  _buildActions() {
    final listActionsWidget = this.actions.map<Widget>((action) {
      return IconButton(
        iconSize: 30,
        color: AppColors.textLight,
        onPressed: action['onPress'],
        icon: Icon(action['icon']),
      );
    }).toList();

    return Row(
      children: listActionsWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(15),
      ),
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
          this.actions.length != 0
              ? _buildActions()
              : IconButton(
                  iconSize: 30,
                  color: AppColors.textLight,
                  onPressed: this.onPressed,
                  icon: Icon(this.icon),
                ),
        ],
      ),
    );
  }
}
