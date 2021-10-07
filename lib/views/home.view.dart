import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Pesquise um músico! :D",
                  hintStyle: TextStyle(
                    color: AppColors.textLight,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: AppColors.textLight,
                ),
              ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              color: AppColors.buttonPrimary,
              child: Icon(Icons.search_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

