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
      home: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Q Calc'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Outcome",
                ),
                Tab(
                  text: "Income",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
//              Icon(Icons.directions_car),
//              Icon(Icons.directions_transit),
              CalculationScreen(CalculationType.OUTCOME),
              CalculationScreen(CalculationType.INCOME),
            ],
          ),
        ),
      ),
    );
  }
}
