import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/profile.model.dart';

class MusicianSummaryWidget extends StatelessWidget {

  final ProfileModel profileModel;

  MusicianSummaryWidget({required this.profileModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/tiaguinho.jpg",
                  height: 140.0,
                  width: 140.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(profileModel.name,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(profileModel.phoneNumber, style: TextStyle(fontSize: 14, color: AppColors.textLowOppacity)),
                    SizedBox(height: 3),
                    Text(profileModel.city, style: TextStyle(fontSize: 14, color: AppColors.textLowOppacity)),
                    SizedBox(height: 3),
                    Text(profileModel.musicGenre.fold("", (prev, curr) => '$prev #$curr'), style: TextStyle(fontSize: 14, color: AppColors.textLowOppacity)),
                    SizedBox(height: 8),
                    Container(
                      width: 154,
                      height: 44,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.buttonPrimary,
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:Text(
                            "Editar Perfil",
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: (){}
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
