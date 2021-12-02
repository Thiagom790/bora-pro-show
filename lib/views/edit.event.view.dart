import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/controllers/location.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/store/profile.store.dart';
import 'package:tcc_bora_show/view-models/event.detail.viewmodel.dart';
import 'package:tcc_bora_show/widgets/event.complete.widget.dart';
import 'package:tcc_bora_show/widgets/event.stepper.widget.dart';

class EditEventView extends StatefulWidget {
  final EventModel event;

  const EditEventView({required this.event, Key? key}) : super(key: key);

  @override
  _EditEventViewState createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  bool _isStepperComplete = false;
  late ProfileStore _store;
  EventModel _eventModel = EventModel();
  final _eventController = EventController();
  final _locationController = LocationController();
  String _titleCompleteWidget = "";
  String _contentCompleteWidget = "";
  bool _isLoading = false;
  bool _isError = false;

  Map<String, dynamic> _validadeEventModel(EventModel model) {
    String errorMessage = "";
    bool isValid = true;

    if (model.title.isEmpty) {
      errorMessage += "Campo nome do evento não preenchido \n\n";
      isValid = false;
    }
    if (model.address.isEmpty) {
      errorMessage += "Campo endereço do evento não preenchido \n\n";
      isValid = false;
    }
    if (model.description.isEmpty) {
      errorMessage += "Campo descrição do evento não preenchido \n\n";
      isValid = false;
    }
    if (model.musicGenre.length < 1) {
      errorMessage += "Escolha um gerenero musical do seu evento \n\n";
      isValid = false;
    }
    if (model.type.trim().isEmpty) {
      errorMessage += "Escolha qual o tipo do seu evento\n\n";
      isValid = false;
    }

    final response = {"isValid": isValid, "message": errorMessage};
    return response;
  }

  Future<void> _editEvent() async {
    final EventModel model = this._eventModel;
    final response = this._validadeEventModel(model);

    if (!response["isValid"]) {
      print("Model de Eventos não passou na validação");
      return;
    }

    model.idProfile = _store.id;

    try {
      if (model.locationID.isNotEmpty) {
        final addressInfo = await this._locationController.getAddresInfo(
              model.locationID,
            );

        model.latitude = addressInfo.latitude;
        model.longitude = addressInfo.longitude;
      }

      final modelMap = model.toMap();
      modelMap['organizerName'] = _store.name;
      final eventModel = EventDetailViewModel.fromMap(modelMap);

      await this._eventController.changeEvent(eventModel);
    } catch (e) {
      throw e;
    }
  }

  void _onSave() {
    setState(() {
      this._isLoading = true;
    });

    this._editEvent().then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      String title = "Erro durante o processo de editar evento";
      String content = error.toString();

      setState(() {
        this._isError = true;
        this._titleCompleteWidget = title;
        this._contentCompleteWidget = content;
        this._isLoading = false;
      });
    });
  }

  void _onStepperComplete(EventModel model) {
    print("Dentro crete event");
    print(model.toMap());

    final response = _validadeEventModel(model);

    String title = response['isValid']
        ? "Sucesso ao validar campos"
        : "Erro ao validar campos:";

    String message = response['message'];

    bool isError = !response['isValid'];

    setState(() {
      this._isError = isError;
      this._titleCompleteWidget = title;
      this._contentCompleteWidget = message;
      this._isStepperComplete = true;
    });
  }

  void _onCancel() {
    setState(() {
      _isStepperComplete = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this._eventModel = widget.event;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._store = Provider.of<ProfileStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Edição de Eventos'),
      ),
      body: _isStepperComplete
          ? EventCompleteWidget(
              title: this._titleCompleteWidget,
              content: this._contentCompleteWidget,
              isLoading: this._isLoading,
              isErro: this._isError,
              onCancel: this._onCancel,
              onSave: this._onSave,
            )
          : EventStepperWidget(
              model: this._eventModel,
              onStepperComplete: this._onStepperComplete,
            ),
    );
  }
}
