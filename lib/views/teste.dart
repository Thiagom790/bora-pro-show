import 'package:flutter/material.dart';
import 'package:tcc_bora_show/views/create.event.view.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LargeButtonWidget(
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEventView()),
          );
        },
        title: "Criar Evento",
      ),
    );
  }
}
