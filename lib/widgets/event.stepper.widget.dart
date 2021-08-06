import 'package:flutter/material.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/widgets/event.address.widget.dart';
import 'package:tcc_bora_show/widgets/event.info.widget.dart';
import 'package:tcc_bora_show/widgets/event.music.widget.dart';

class EventStepperWidget extends StatefulWidget {
  const EventStepperWidget({Key? key}) : super(key: key);

  @override
  _EventStepperWidgetState createState() => _EventStepperWidgetState();
}

class _EventStepperWidgetState extends State<EventStepperWidget> {
  EventModel _eventModel = EventModel();

  List<Map<String, dynamic>> _stepsInfo = [];
  int _currentStep = 0;

  void _getStepsInfo() {
    this._stepsInfo = [
      {
        "id": 0,
        "title": "Informações",
        "widget": EventInfoWidget(
          model: this._eventModel,
        ),
      },
      {"id": 1, "title": "Endereço", "widget": EventAddressWidget()},
      {"id": 2, "title": "Musicos", "widget": EventMusicWidget()},
    ];
  }

  Step _buildStep(Map<String, dynamic> data) {
    String title = data['title'];
    Widget content = data['widget'];
    int id = data['id'];
    bool isActive = id == this._currentStep;

    return Step(
      title: Text(title, style: TextStyle(color: AppColors.textLight)),
      isActive: isActive,
      content: content,
    );
  }

  List<Step> get _steps {
    List<Step> stepList = this._stepsInfo.map<Step>(_buildStep).toList();
    return stepList;
  }

  void _nextStep() {
    this._currentStep + 1 < this._stepsInfo.length
        ? this._goTo(this._currentStep + 1)
        : print("False");
  }

  void _prevStep() {
    int nextStep = this._currentStep - 1;
    if (nextStep >= 0) {
      this._goTo(nextStep);
    }
  }

  void _goTo(int step) {
    setState(() {
      this._currentStep = step;
    });
  }

  @override
  void initState() {
    super.initState();
    this._getStepsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: AppColors.background),
      child: Stepper(
        type: StepperType.horizontal,
        currentStep: this._currentStep,
        steps: this._steps,
        onStepContinue: this._nextStep,
        onStepCancel: this._prevStep,
        onStepTapped: this._goTo,
      ),
    );
  }
}
