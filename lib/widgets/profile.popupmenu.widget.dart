import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/view-models/profile.viewmodel.dart';

class ProfilePopupMenuWidget extends StatelessWidget {
  final List<ProfileViewModel> profiles;
  final ProfileViewModel defaultProfile;
  final void Function(ProfileViewModel) onSelect;
  final Function onCreateProfile;

  ProfilePopupMenuWidget({
    Key? key,
    required this.profiles,
    required this.defaultProfile,
    required this.onSelect,
    required this.onCreateProfile,
  }) : super(key: key);

  PopupMenuItem<ProfileViewModel> _createItem(ProfileViewModel profile) {
    return PopupMenuItem(
      child: Text(profile.name),
      value: profile,
    );
  }

  List<PopupMenuItem<ProfileViewModel>> _handleItemBuilder(context) {
    this.profiles.remove(defaultProfile);
    var popupItens = this.profiles.map(this._createItem).toList();

    var btnProfile = ProfileViewModel(id: "button", name: "Criar Novo Perfil");
    var btnAddProfile = this._createItem(btnProfile);

    popupItens.add(btnAddProfile);

    return popupItens;
  }

  void _handleSelect(ProfileViewModel profile) {
    if (profile.id == 'button') {
      this.onCreateProfile();
      return;
    }
    this.onSelect(profile);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ProfileViewModel>(
      child: Row(
        children: <Widget>[
          Text(
            defaultProfile.name,
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: 20,
            ),
          ),
          Icon(
            Icons.expand_more,
            size: 30,
            color: AppColors.textLight,
          ),
        ],
      ),
      itemBuilder: this._handleItemBuilder,
      onSelected: this._handleSelect,
    );
  }
}
