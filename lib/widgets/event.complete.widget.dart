import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/widgets/button.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';
import 'package:tcc_bora_show/widgets/rounded.image.widget.dart';

class EventCompleteWidget extends StatelessWidget {
  final bool isLoading;
  final bool isErro;
  final String title;
  final String content;
  final void Function() onCancel;
  final void Function() onSave;

  const EventCompleteWidget({
    required this.onCancel,
    required this.onSave,
    required this.title,
    this.content = "",
    this.isLoading = false,
    this.isErro = false,
    Key? key,
  }) : super(key: key);

  List<Widget> get _buttonsController {
    List<Widget> buttons = [
      ButtonWidget(
        title: "Cancelar",
        onPress: this.onCancel,
        isBusy: this.isLoading,
      ),
      SizedBox(
        width: 10,
      ),
      ButtonWidget(
        title: "Salvar",
        onPress: this.onSave,
        isBusy: this.isLoading,
      )
    ];

    if (this.isErro) {
      buttons = [
        ButtonWidget(
          title: "Voltar",
          onPress: this.onCancel,
          width: 200,
          isBusy: this.isLoading,
        ),
      ];
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    if (this.isLoading) {
      return LoadingWidget();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                RoundedImageWidget(
                  path: this.isErro ? "assets/error.png" : "assets/success.png",
                ),
                Text(
                  this.title,
                  style: TextStyle(fontSize: 20, color: Color(0xffB6CDF0)),
                ),
                Text(
                  this.content,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: AppColors.textLight),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: this._buttonsController,
            )
          ],
        ),
      ),
    );
  }
}
