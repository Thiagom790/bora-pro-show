import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class MusicianSearchBar extends StatelessWidget {
  final void Function(String valorDigitado) onPressed;
  final controller = TextEditingController();

  MusicianSearchBar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: AppColors.textLight, fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Pesquise pelo seu musico",
                hintStyle: TextStyle(color: AppColors.textLight),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
          ),
          Container(
            width: 60,
            height: 50,
            margin: EdgeInsets.only(left: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                primary: AppColors.buttonPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () => this.onPressed(controller.text.trim()),
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
