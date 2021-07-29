import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tcc_bora_show/controllers/location.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/address.model.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final _controller = LocationController();
  List<Step> _stepList = [];
  bool _isLoadedSuggest = false;
  int _currentStep = 0;
  bool _isComplete = false;

  _nextStep() {
    _currentStep + 1 != this._stepList.length
        ? _goTo(_currentStep + 1)
        : setState(() => _isComplete = true);
  }

  _cancelStep() {
    if (this._currentStep > 0) {
      _goTo(this._currentStep - 1);
    }
  }

  _goTo(int step) {
    setState(() => this._currentStep = step);
  }

  Future<List<AddressModel>> _handleSuggestion(String location) async {
    // return await _controller.locationSuggestion(location);
    List<AddressModel> lista = [
      AddressModel(description: "Descrição de teste maroto do mal"),
      AddressModel(description: "Descrição de teste maroto do mal"),
      AddressModel(description: "Descrição de teste maroto do mal"),
    ];
    return lista;
  }

  Widget _builderSuggestion(BuildContext context, AddressModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      color: AppColors.container,
      child: Text(
        '${model.description}',
        style: TextStyle(fontSize: 15, color: AppColors.textLight),
      ),
    );
  }

  void _showDatePicker() async {
    final initialDate = DateTime.now();

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(DateTime.now().year + 10),
    );
  }

  List<Step> _getStepList() {
    return [
      Step(
        title: Text('Informações', style: TextStyle(color: Colors.white)),
        isActive: true,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            InputWidget(
              placeholder: "Nome do Evento",
            ),
            InputWidget(
              placeholder: "Data",
              onTap: this._showDatePicker,
            ),
            InputWidget(
              placeholder: "Estilo",
            ),
            InputWidget(
              placeholder: "Descrição do Evento",
              maxLines: 8,
            ),
          ],
        ),
      ),
      Step(
        title: Text('Endereços', style: TextStyle(color: Colors.white)),
        isActive: false,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(fontSize: 20, color: AppColors.textLight),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.container,
                    hintText: "Endereço",
                    hintStyle: TextStyle(color: AppColors.textLight),
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                suggestionsCallback: this._handleSuggestion,
                itemBuilder: this._builderSuggestion,
                onSuggestionSelected: (model) {},
                keepSuggestionsOnLoading: this._isLoadedSuggest,
              ),
            ),
            InputWidget(
              placeholder: "Numero",
            ),
          ],
        ),
      ),
      Step(
        title: Text('Artistas', style: TextStyle(color: Colors.white)),
        isActive: false,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            Text('Zeca baleiro'),
            Text('Zeca baleiro'),
            Text('Zeca baleiro'),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    this._stepList = this._getStepList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.container,
        title: Text('Criação de evento'),
      ),
      body: Theme(
        data: ThemeData(
          canvasColor: AppColors.background,
        ),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: this._currentStep,
          onStepContinue: this._nextStep,
          onStepCancel: this._cancelStep,
          onStepTapped: (step) => _goTo(step),
          controlsBuilder: (context, {onStepContinue, onStepCancel}) {
            return Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: onStepContinue,
                  child: Text('Próximo'),
                ),
                ElevatedButton(
                  onPressed: onStepCancel,
                  child: Text('Anterior'),
                ),
              ],
            );
          },
          steps: this._stepList,
        ),
      ),
    );
  }
}