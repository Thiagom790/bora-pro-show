import 'package:flutter/material.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';

class EventInfoWidget extends StatelessWidget {
//   final EventModel model;
  const EventInfoWidget({
    // required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputWidget(
          placeholder: "Nome do Evento",
        )
      ],
    );
  }
}
