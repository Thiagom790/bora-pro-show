import 'package:flutter/material.dart';
import 'package:tcc_bora_show/controllers/event.controller.dart';
import 'package:tcc_bora_show/core/app.colors.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/utils/date.utils.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';
import 'package:tcc_bora_show/widgets/selectbox.widget.dart';

class EventInfoWidget extends StatefulWidget {
  final EventModel model;

  EventInfoWidget({
    required this.model,
  });

  @override
  _EventInfoWidgetState createState() => _EventInfoWidgetState();
}

class _EventInfoWidgetState extends State<EventInfoWidget> {
// inputs variables
  final _controllerTitle = TextEditingController();
  final _controllerDate = TextEditingController();
  final _controllerHour = TextEditingController();
  final _controllerMusicGenre = TextEditingController();
  final _controllerDescription = TextEditingController();

// general variables
  late EventModel _model;
  final _controllerEvent = EventController();
  late List<Map<String, dynamic>> _listEventTypes;
  late List<Map<String, dynamic>> _listEventGenre = [];
  final List<String> _selectedEventGenre = [];
  String _textSelectType = "Tipo do Evento";
  bool _isOpenToPublic = true;

  List<Map<String, dynamic>> _getEventGenres() {
    final listGenres = _controllerEvent.selectEventGenres();

    List<Map<String, dynamic>> listFormateGenres = [];
    listGenres.forEach((genre) {
      listFormateGenres.add({"value": genre, "isActive": false});
    });

    return listFormateGenres;
  }

  void _buildFields() {
    this._controllerTitle.text = this.widget.model.title;
    this._controllerDescription.text = this.widget.model.description;
    this._controllerMusicGenre.text = "Genero Músical";

    final date = this.widget.model.date;
    this._controllerDate.text = dateFormat(date);

    final time = this.widget.model.time;
    this._controllerHour.text = timeFormat(time);

    _listEventTypes = this._controllerEvent.selectEventTypes();
    _listEventGenre = this._getEventGenres();
  }

  void _onTapSelectGenre() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Generos Musicais"),
              content: Container(
                width: 300,
                height: 300,
                child: ListView.builder(
                  itemCount: this._listEventGenre.length,
                  itemBuilder: (context, index) {
                    final item = _listEventGenre[index];
                    return CheckboxListTile(
                      title: Text(item["value"]),
                      value: item["isActive"],
                      onChanged: (value) {
                        setState(() {
                          item["isActive"] = value;
                          value!
                              ? _selectedEventGenre.add(item["value"])
                              : _selectedEventGenre.remove(item["value"]);
                        });
                        this._model.musicGenre = _selectedEventGenre;
                      },
                    );
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                  child: Text('Concluir'),
                  onPressed: () {
                    this._controllerMusicGenre.text = _selectedEventGenre.fold(
                        "", (prev, curr) => '$prev #$curr');
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  void _onChangeSelectType(Map<String, dynamic>? typeInfo) {
    if (typeInfo != null) {
      setState(() {
        this._model.type = typeInfo['id'];
        print("Printe dentro de event info widget " + _model.type);
        _textSelectType = typeInfo['value'];
      });
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final initialDate = DateTime.now();

    final dateSelected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (dateSelected == null) {
      return;
    }

    this.widget.model.date = dateSelected;

    String dateFormated = dateFormat(dateSelected);
    _controllerDate.text = dateFormated;
  }

  Future<void> _showHourPicker(BuildContext context) async {
    final initialTime = TimeOfDay.now();

    final timeSelected = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (timeSelected == null) {
      return;
    }

    this.widget.model.time = timeSelected;

    String timeFormated = timeFormat(timeSelected);
    _controllerHour.text = timeFormated;
  }

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    _buildFields();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Image.asset("assets/logo2.png"),
        ),
        InputWidget(
          placeholder: "Titulo",
          controller: this._controllerTitle,
          onChange: (text) => widget.model.title = text,
        ),
        InputWidget(
          placeholder: "Data",
          readOnly: true,
          controller: this._controllerDate,
          onTap: () => this._showDatePicker(context),
        ),
        InputWidget(
          placeholder: "Hora",
          readOnly: true,
          controller: this._controllerHour,
          onTap: () => this._showHourPicker(context),
        ),
        SelectBoxWidget(
          onChange: this._onChangeSelectType,
          listData: this._listEventTypes,
          displayText: this._textSelectType,
        ),
        InputWidget(
          placeholder: "Genero Musical",
          readOnly: true,
          controller: this._controllerMusicGenre,
          onTap: this._onTapSelectGenre,
        ),
        InputWidget(
          placeholder: "Descrição",
          controller: this._controllerDescription,
          onChange: (text) => widget.model.description = text,
          maxLines: 8,
        ),
        SwitchListTile(
          title: Text(
            'Aberto ao Publico',
            style: TextStyle(color: AppColors.textLight, fontSize: 20),
          ),
          value: this._isOpenToPublic,
          onChanged: (value) {
            setState(() {
              _isOpenToPublic = value;
              _model.isOpenToPublic = value;
            });
          },
        ),
      ],
    );
  }
}
