import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class EventCardMusician extends StatelessWidget {
  final String title;
  final void Function()? onPress;

  EventCardMusician({required this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 140,
      height: 170,
      child: GestureDetector(
        onTap: this.onPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/shows.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                color: AppColors.container,
                child: Text(
                  this.title,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
