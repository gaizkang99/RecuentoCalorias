import 'dart:math';
import 'package:flutter/material.dart';

import 'models/comida.dart';
import 'widgets/listaComida.dart';
import 'widgets/new_Comida.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Comida> _activities = [];

  final randomGen = Random();

  void _addNewActivity(String name, double calorias, DateTime date) {
    final newAct = Comida(
      id: randomGen.nextInt(10000),
      name: name,
      calorias: calorias,
      date: date,
    );

    setState(() {
      _activities.add(newAct);
    });
  }

  void _startNewActivity(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewComida(_addNewActivity);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(
        activities: _activities,
        addNewActivity: _addNewActivity,
        startNewActivity: _startNewActivity,
      ),
    );
  }
}

class Main extends StatelessWidget {
  final Function(BuildContext) startNewActivity;
  final Function(String, double, DateTime) addNewActivity;
  final List<Comida> activities;

  Main({
    required this.startNewActivity,
    required this.addNewActivity,
    required this.activities,
  });

  List<Comida> get _recentActivities {
    return activities.where((activity) {
      return activity.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calories App"),
      ),
      body: ListView(
        children: [
          if(activities.isEmpty)...[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Center(
                child: Text("Actualmente no tienes ningun registro",
                style: TextStyle(fontSize: 20),),
              ),
            )
          ]else...[
            listaComida(activities),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startNewActivity(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
