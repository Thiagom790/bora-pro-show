import 'package:flutter/material.dart';
import 'package:tcc_bora_show/models/event.model.dart';
import 'package:tcc_bora_show/widgets/input.widget.dart';

class EventInfoWidget extends StatelessWidget {
  final _controllerName = TextEditingController();
  final _controllerDate = TextEditingController();
  final _controllerHour = TextEditingController();
  final _controllerGenre = TextEditingController();
  final _controllerDescription = TextEditingController();
  final EventModel model;

  EventInfoWidget({
    required this.model,
  });

  void _buildControllers() {
    this._controllerName.text = this.model.title;
    this._controllerDate.text = this.model.date;
    this._controllerHour.text = this.model.time;
    this._controllerGenre.text = this.model.genre;
    this._controllerDescription.text = this.model.description;
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

    String dateFormated =
        "${dateSelected.day}/${dateSelected.month}/${dateSelected.year}";

    model.date = dateFormated;
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

    String timeFormated = "${timeSelected.hour}:${timeSelected.minute}";

    model.time = timeFormated;
    _controllerHour.text = timeFormated;
  }

  @override
  Widget build(BuildContext context) {
    _buildControllers();

    return Column(
      children: <Widget>[
        InputWidget(
          placeholder: "Nome",
          controller: this._controllerName,
          onChange: (text) => model.title = text,
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
        InputWidget(
          placeholder: "Estilo",
          controller: this._controllerGenre,
          onChange: (text) => model.genre = text,
        ),
        InputWidget(
          placeholder: "Descrição",
          controller: this._controllerDescription,
          onChange: (text) => model.description = text,
          maxLines: 8,
        ),
      ],
    );
  }
}
