import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/widgets/event.stepper.widget.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  void _onStepperComplete(EventModel model) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Criação de Eventos'),
        backgroundColor: AppColors.container,
      ),
      body: EventStepperWidget(
        onStepperComplete: this._onStepperComplete,
      ),
    );
  }
}
