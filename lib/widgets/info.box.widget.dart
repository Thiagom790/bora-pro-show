import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class InfoBoxWidget extends StatelessWidget {
  final String title;
  final String content;

  InfoBoxWidget({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.textLight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textLight,
              ),
            ),
          ),
          Text(
            this.content,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textAccent,
            ),
          ),
        ],
      ),
    );
  }
}
