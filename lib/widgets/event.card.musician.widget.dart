import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.model.dart';

class EventCardMusician extends StatelessWidget {

  //final EventModel eventModel;

  //EventCardMusician({required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: (){},
        child: Stack(
          children: <Widget>[
            Container(
              width: 140,
              height: 170,
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 134),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                width: 140,
                height: 36,
                //color: AppColors.container,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                  color: AppColors.container,
                ),
                child: Text("Bar do Zé", style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
