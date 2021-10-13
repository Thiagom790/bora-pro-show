import 'package:flutter/material.dart';
import 'package:tcc_bora_show/widgets/rounded.image.widget.dart';

class ErrorCustomWidget extends StatelessWidget {
  final String errorTitle;
  const ErrorCustomWidget({
    Key? key,
    required this.errorTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedImageWidget(
            path: "assets/error.png",
          ),
          Text(
            this.errorTitle,
            style: TextStyle(fontSize: 20, color: Color(0xffB6CDF0)),
          ),
        ],
      ),
    );
  }
}
