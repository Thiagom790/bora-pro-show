import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/post.model.dart';
import 'package:tcc_bora_show/utils/date.utils.dart';

class Postwidget extends StatelessWidget {
  final void Function()? profileOnTap;
  final void Function()? likeOnTap;
  final void Function()? commentOnTap;
  final PostModel postModel;

  Postwidget({
    this.profileOnTap,
    this.likeOnTap,
    this.commentOnTap,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: <Widget>[
              Icon(Icons.person, color: AppColors.textLight, size: 38),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "${this.postModel.musicianName}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    onTap: profileOnTap,
                  ),
                  Text(
                    "${dateFormat(this.postModel.date)}",
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textLowOppacity,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: 100,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.container,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            "${this.postModel.text}",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            children: <Widget>[
              TextButton(
                onPressed: likeOnTap,
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/rock-and-roll-white.png",
                      width: 35,
                      height: 30,
                    ),
                    Text(
                      "${this.postModel.numLikes}",
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: commentOnTap,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.comment,
                        color: AppColors.textLight,
                      ),
                    ),
                    Text(
                      "${this.postModel.numComments}",
                      style: TextStyle(color: AppColors.textLight),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
