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
  int _currentStep = 1;
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
    return await _controller.locationSuggestion(location);
  }

  Widget _builderSuggestion(BuildContext context, AddressModel model) {
    return Text(
      'Main: ${model.mainText} descrip: ${model.description}',
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
              placeholder: "Data e Horario",
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
            TypeAheadField(
              suggestionsCallback: this._handleSuggestion,
              itemBuilder: this._builderSuggestion,
              onSuggestionSelected: (model) {},
              keepSuggestionsOnLoading: this._isLoadedSuggest,
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

//  SingleChildScrollView(
//   padding: EdgeInsets.all(20),
//   child: Column(
//     children: <Widget>[
//       InputWidget(
//         controller: _controllerNomeShow,
//         placeholder: "Nome do Show",
//       ),
//       InputWidget(
//         controller: _controllerNomeShow,
//         placeholder: "Local",
//       ),
//       InputWidget(
//         controller: _controllerNomeShow,
//         placeholder: "Data/Horario",
//       ),
//       InputWidget(
//         controller: _controllerNomeShow,
//         placeholder: "Descrição ",
//         maxLines: 8,
//       ),
//       Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: AppColors.container,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               margin: EdgeInsets.only(bottom: 10),
//               child: Text(
//                 'Artistas',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   color: AppColors.textLight,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               child: OutlinedButton(
//                 onPressed: () {},
//                 child: Text('Adicionar'),
//                 style: OutlinedButton.styleFrom(
//                   primary: AppColors.textLight,
//                   textStyle: TextStyle(fontSize: 16),
//                   side: BorderSide(color: AppColors.textLight, width: 2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       LargeButtonWidget(onPress: () {}, title: "Criar Evento")
//     ],
//   ),
// );
