import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class LargeButtonWidget extends StatelessWidget {
  final void Function() onPress;
  final String title;
  final bool isBusy;
  const LargeButtonWidget({
    Key? key,
    required this.onPress,
    required this.title,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors.buttonPrimary,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: this.isBusy
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
        onPressed: this.isBusy ? () {} : onPress,
      ),
    );
  }
}
