import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/comida.dart';


class listaComida extends StatefulWidget {
  listaComida(this._activities);
  final List<Comida> _activities;

  @override
  _listadoComida createState() => _listadoComida();
}

class _listadoComida extends State<listaComida>{
  @override
  Widget build(BuildContext context) {
    widget._activities.sort(((a, b) {
      return b.date.compareTo(a.date);
    }));
    return Column(
      children: widget._activities.map((activity) {
        return Card(
          child: Row(
            children: [
              Container(
                child: Text(
                  '${activity.calorias.toString()} kcal',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3,
                  ),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                padding: EdgeInsets.all(12),
              ),
              Column(
                children: [
                  Text(
                    activity.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy hh:mm:ss').format(activity.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      widget._activities.remove(activity);
                    });
                  },
                  icon: Icon(Icons.delete),
                  label: Text(""),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

}