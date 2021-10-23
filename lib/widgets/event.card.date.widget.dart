import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/utils/date.utils.dart';

class EventCardDateWidget extends StatelessWidget {
  final DateTime date;
  const EventCardDateWidget({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(15),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "${this.date.day}\n",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textAccent,
              ),
            ),
            TextSpan(
              text: "${shortMonth(this.date.month)}",
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textLight.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
