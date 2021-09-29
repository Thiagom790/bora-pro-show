import 'package:flutter/material.dart';

class LargeOutlineButtonWidget extends StatelessWidget {
  final String title;
  final void Function() onPress;
  final bool isBusy;

  const LargeOutlineButtonWidget({
    Key? key,
    required this.title,
    required this.onPress,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(color: Colors.white, width: 2),
        minimumSize: Size(double.infinity, 50),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        textStyle: TextStyle(
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: this.isBusy ? () {} : this.onPress,
      child: this.isBusy
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text(this.title),
    );
  }
}
