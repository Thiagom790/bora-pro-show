import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/core/app.menu.data.dart';

class NavyBarBottonWidget extends StatelessWidget {
  final void Function(int) onItemSelected;
  final String role;
  final int selectIndex;

  NavyBarBottonWidget({
    required this.role,
    required this.onItemSelected,
    required this.selectIndex,
  });

  List<BottomNavyBarItem> get listItens {
    var data = menuData[role];
    return data!.map<BottomNavyBarItem>((Map<String, dynamic> data) {
      return BottomNavyBarItem(
        textAlign: TextAlign.center,
        inactiveColor: AppColors.navyItemInactive,
        activeColor: AppColors.navyItemActive,
        icon: data["icon"],
        title: Text(data['title']),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      backgroundColor: AppColors.container,
      selectedIndex: selectIndex,
      items: listItens,
      onItemSelected: onItemSelected,
    );
  }
}
