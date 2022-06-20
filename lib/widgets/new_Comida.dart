import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewComida extends StatefulWidget {
  final Function(String, double, DateTime) _addNewComidaHandler;

  NewComida(this._addNewComidaHandler);

  @override
  State<NewComida> createState() => _NewComidaState();
}

class _NewComidaState extends State<NewComida> {
  final titleController = TextEditingController();
  final distanceController = TextEditingController();
  var _selectedDate;

  void _submit() {
    final distance = double.parse(distanceController.text);
    if (titleController.text.isEmpty || distance < 0 || distance > 5000 || _selectedDate == null) {
      return;
    }

    widget._addNewComidaHandler(
      titleController.text,
      distance,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      print(value);
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Nombre de la comida'),
            ),
            TextField(
              controller: distanceController,
              decoration: InputDecoration(labelText: 'Calorías'),
              keyboardType: TextInputType.number,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Sin fecha seleccionada"
                          : DateFormat.yMd().format(_selectedDate),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Seleccionar fecha',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
              height: 80,
            ),
            RaisedButton(
              child: Text('Guardar'),
              color: Colors.green,
              onPressed: () {
                _submit();
              },
              textColor: Colors.white,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        padding: EdgeInsets.all(20),
      ),
      elevation: 8,
    );
  }
}
