import 'package:flutter/material.dart';
import 'package:tcc_bora_show/views/create.event.view.dart';
import 'package:tcc_bora_show/widgets/large.button.widget.dart';

class EventsView extends StatefulWidget {
  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  void _createEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateEventView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: LargeButtonWidget(onPress: _createEvent, title: "Criar evento"),
    );
  }
}
