import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/controllers/location.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/address.model.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/loading.widget.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerTime = TextEditingController();
  final TextEditingController _controllerGenre = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  final _locationController = LocationController();
  final _eventControlle = EventControlle();
  late ProfileStore _store;

  List<Step> _stepList = [];
  bool _isLoadedSuggest = false;
  int _currentStep = 0;
  bool _isComplete = false;
  bool _isLoading = false;
  AddressModel? _currentAddress;
  String _errorMessage = "";

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
    return await _locationController.locationSuggestion(location);
    // List<AddressModel> lista = [
    //   AddressModel(description: "Descrição de teste maroto do mal"),
    //   AddressModel(description: "Descrição de teste maroto do mal"),
    //   AddressModel(description: "Descrição de teste maroto do mal"),
    // ];
    // return lista;
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

  void _handleSuggestionSelected(AddressModel model) {
    this._controllerAddress.text = model.description;

    if (model.id == null) {
      return;
    }

    this._currentAddress = model;
  }

  void _showDatePicker() async {
    final initialDate = DateTime.now();

    final selecDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (selecDate == null) {
      return;
    }

    String formatedDate =
        "${selecDate.day}/${selecDate.month}/${selecDate.year}";

    _controllerDate.text = formatedDate;
  }

  void _showHourPicker() async {
    final initialTime = TimeOfDay.now();

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime == null) {
      return;
    }

    String formatedTime = "${selectedTime.hour}:${selectedTime.minute}";

    _controllerTime.text = formatedTime;
  }

  Future<void> _createEvent() async {
    try {
      var address =
          await _locationController.getAddresInfo(this._currentAddress!.id!);

      final model = EventModel(
        idProfile: _store.id,
        title: _controllerName.text,
        genre: _controllerGenre.text,
        date: _controllerDate.text,
        time: _controllerTime.text,
        latitude: address.latitude,
        longitude: address.longitude,
        address: _currentAddress!.description,
        description: _controllerDescription.text,
        status: "progress",
      );

      await this._eventControlle.createEvent(model);
    } catch (e) {
      throw e;
    }
  }

  void _handleCreateEvent() {
    setState(() {
      _isLoading = true;
    });

    this._createEvent().then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      setState(() {
        this._errorMessage = error.message;
        this._isLoading = false;
      });
    });
  }

  Widget get _eventInfo {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            this._errorMessage.isEmpty
                ? "Informações do Evento"
                : this._errorMessage,
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: this._handleCreateEvent,
                child: Text('Salvar'),
              ),
              ElevatedButton(
                child: Text('Cancelar'),
                onPressed: () {
                  setState(() {
                    this._isComplete = false;
                  });
                },
              ),
            ],
          )
        ],
      ),
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
              controller: this._controllerName,
              placeholder: "Nome do Evento",
            ),
            InputWidget(
              placeholder: "Data",
              controller: _controllerDate,
              onTap: this._showDatePicker,
              readOnly: true,
            ),
            InputWidget(
              placeholder: "Hora",
              controller: _controllerTime,
              onTap: this._showHourPicker,
              readOnly: true,
            ),
            InputWidget(
              controller: this._controllerGenre,
              placeholder: "Estilo",
            ),
            InputWidget(
              controller: this._controllerDescription,
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
                  controller: this._controllerAddress,
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
                onSuggestionSelected: this._handleSuggestionSelected,
                keepSuggestionsOnLoading: this._isLoadedSuggest,
              ),
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

  Widget get _body {
    if (this._isLoading) {
      return LoadingWidget();
    }

    if (this._isComplete) {
      return this._eventInfo;
    }

    return Theme(
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              this._currentStep == 0
                  ? Container()
                  : ElevatedButton(
                      onPressed: onStepCancel,
                      child: Text('Anterior'),
                    ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: onStepContinue,
                child: Text('Próximo'),
              ),
            ],
          );
        },
        steps: this._stepList,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
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
      body: this._body,
    );
  }
}
