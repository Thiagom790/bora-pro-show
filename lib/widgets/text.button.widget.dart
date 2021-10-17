import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class TextButtonWidget extends StatelessWidget {
  final bool isActive;
  final String title;
  final void Function() onPress;
  final IconData? icon;

  const TextButtonWidget({
    Key? key,
    required this.title,
    required this.onPress,
    this.isActive = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: TextButton.icon(
        onPressed: this.onPress,
        icon: Icon(
          this.icon,
          size: 18,
        ),
        label: Text(this.title),
        style: TextButton.styleFrom(
          primary: isActive ? AppColors.textLight : AppColors.textAccent,
          backgroundColor:
              isActive ? AppColors.textAccent : AppColors.container,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
