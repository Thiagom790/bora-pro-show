import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double width;
  final String title;
  final void Function() onPress;
  final bool isBusy;
  final Color? color;

  const ButtonWidget({
    required this.title,
    required this.onPress,
    this.width = 100,
    this.isBusy = false,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: this.color,
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: this.isBusy
            ? CircularProgressIndicator()
            : Text(
                this.title,
                style: TextStyle(fontSize: 15),
              ),
        onPressed: this.isBusy ? () {} : this.onPress,
      ),
    );
  }
}
