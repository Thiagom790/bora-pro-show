import 'package:flutter/material.dart';
import 'package:tcc_bora_show/views/create.event.view.dart';

class EventManagement extends StatelessWidget {
  const EventManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEventView()),
          );
        },
        child: Text('Criar Evento'),
      ),
    );
  }
}
