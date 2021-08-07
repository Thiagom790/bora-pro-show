import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class RoundedImageWidget extends StatelessWidget {
  final String path;
  const RoundedImageWidget({
    required this.path,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.all(30),
      child: Image.asset(
        this.path,
        width: 100,
      ),
    );
  }
}
