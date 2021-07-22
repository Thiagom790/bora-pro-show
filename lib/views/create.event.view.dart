import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  TextEditingController _controllerNomeShow = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.container,
        title: Text('Criação de evento'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            InputWidget(
              controller: _controllerNomeShow,
              placeholder: "Nome do Show",
            ),
            InputWidget(
              controller: _controllerNomeShow,
              placeholder: "Local",
            ),
            InputWidget(
              controller: _controllerNomeShow,
              placeholder: "Data/Horario",
            ),
            InputWidget(
              controller: _controllerNomeShow,
              placeholder: "Descrição ",
              maxLines: 8,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.container,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Artistas',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Adicionar'),
                      style: OutlinedButton.styleFrom(
                        primary: AppColors.textLight,
                        textStyle: TextStyle(fontSize: 16),
                        side: BorderSide(color: AppColors.textLight, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LargeButtonWidget(onPress: () {}, title: "Criar Evento")
          ],
        ),
      ),
    );
  }
}
