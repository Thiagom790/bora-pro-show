import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/core/app.menu.data.dart';

class SelectProfileWidget extends StatelessWidget {
  final List<String> listTypeProfiles = profileTypes;
  final String? profileType;
  final void Function(String?) onChange;

  SelectProfileWidget({
    Key? key,
    required this.profileType,
    required this.onChange,
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
        child: DropdownButton<String>(
          value: profileType,
          dropdownColor: AppColors.container,
          hint: Text(
            'Selecione o tipo de Perfil',
            style: TextStyle(color: AppColors.textLight, fontSize: 20),
          ),
          items: listTypeProfiles.map((data) {
            return DropdownMenuItem(
              child: Text(
                data,
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
