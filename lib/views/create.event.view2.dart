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
  bool _isStepperComplete = false;

  void _onStepperComplete(EventModel model) {
    print("Dentro crete event");
    print(model.toMap());

    setState(() {
      this._isStepperComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Criação de Eventos'),
        backgroundColor: AppColors.container,
      ),
      body: !_isStepperComplete
          ? EventStepperWidget(onStepperComplete: this._onStepperComplete)
          : Container(),
    );
  }
}
