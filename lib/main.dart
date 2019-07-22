import 'package:flutter/material.dart';

import 'calculation_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Q Calc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Q Calc'),
        ),
        body: CalculationScreen(
          CalculationType.OUTCOME
        ),
      ),
    );
  }
}