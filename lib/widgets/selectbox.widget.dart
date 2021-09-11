import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';

class SelectBoxWidget extends StatelessWidget {
  final List<Map<String, dynamic>> listData;
  final void Function(Map<String, dynamic>?) onChange;
  final String displayText;

  SelectBoxWidget({
    Key? key,
    required this.onChange,
    required this.listData,
    required this.displayText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Map<String, dynamic>>(
          value: null,
          dropdownColor: AppColors.container,
          hint: Text(
            this.displayText,
            style: TextStyle(color: AppColors.textLight, fontSize: 20),
          ),
          items: this.listData.map((data) {
            return DropdownMenuItem(
              child: Text(
                data["value"],
                style: TextStyle(color: AppColors.textLight, fontSize: 20),
              ),
              value: data,
            );
          }).toList(),
          onChanged: this.onChange,
        ),
      ),
    );
  }
}
