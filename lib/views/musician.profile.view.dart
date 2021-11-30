import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/profile.model.dart';
import 'package:tcc_bora_show/views/create.post.view.dart';
import 'package:tcc_bora_show/widgets/button.widget.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/musician.summary.widget.dart';
import 'package:tcc_bora_show/widgets/post.widget.dart';

class musicianProfile extends StatefulWidget {
  const musicianProfile({Key? key}) : super(key: key);

  @override
  _musicianProfileState createState() => _musicianProfileState();
}

class _musicianProfileState extends State<musicianProfile> {

  @override


  ProfileModel CriarMusico(){
    List<String> musica = ["oi"];
    ProfileModel profileModel = new ProfileModel();
    profileModel.name = "oi";
    profileModel.phoneNumber = "333";
    profileModel.city = "carapicuiba";
    profileModel.musicGenre = musica;

    return profileModel;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: MusicianSummaryWidget(
          profileModel: CriarMusico(),
        )
    );

  }
}
