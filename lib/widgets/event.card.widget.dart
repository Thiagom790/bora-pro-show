import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class EventCardWidget extends StatelessWidget {
  final String status;
  final String title;
  final String location;

  const EventCardWidget({
    Key? key,
    required this.status,
    required this.title,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.container,
        image: DecorationImage(
          image: AssetImage("assets/shows.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            this.status,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textAccent,
            ),
          ),
          Text(
            this.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textLight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              this.location,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
