import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class DescriptionWidget extends StatelessWidget {
  final String title;
  final String content;

  DescriptionWidget({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textLight,
              ),
            ),
          ),
          Text(
            this.content,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
