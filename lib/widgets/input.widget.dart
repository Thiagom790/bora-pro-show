import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class InputWidget extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final TextInputType keyboard;
  final bool autofocus;
  final bool obscure;
  final bool readOnly;
  final int maxLines;
  final void Function()? onTap;

  const InputWidget({
    Key? key,
    this.controller,
    this.placeholder = "",
    this.keyboard = TextInputType.text,
    this.autofocus = false,
    this.obscure = false,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: TextStyle(color: AppColors.textLight, fontSize: 20),
        controller: controller,
        keyboardType: keyboard,
        autofocus: autofocus,
        obscureText: obscure,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: AppColors.textLight),
          filled: true,
          fillColor: AppColors.container,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(20),
        ),
        onTap: this.onTap,
        readOnly: this.readOnly,
      ),
    );
  }
}
