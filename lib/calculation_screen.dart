import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'logic/calculator.dart';
import 'exceptions.dart';


class CalculationScreen extends StatefulWidget {
  final CalculationType _type;

  CalculationScreen(this._type);

  @override
  _CalculationScreenState createState() => _CalculationScreenState(_type);
}

class _CalculationScreenState extends State<CalculationScreen> {

  CalculationType _type;
  var _incomeCalc = IncomeCalculator();
  var _outcomeCalc = OutcomeCalculator();

  final _sumController = TextEditingController();
  final _percentController = TextEditingController();
  final _precisionController = TextEditingController();

  String result;

  _CalculationScreenState(CalculationType type) {
    _type = type;
    if (_type == null) {
      _type = CalculationType.INCOME;
    }
  }

  void _calc() {
    double sum = _sumController.text.isEmpty ? 0 : double.parse(_sumController.text);
    sum = sum == null ? 0 : sum;

    int precision = _precisionController.text.isEmpty ? 0 : int.parse(_precisionController.text);
    precision = precision == null ? 0 : precision;

    double percent = _percentController.text.isEmpty ? 0 : double.parse(_percentController.text);
    percent = percent == null ? 0 : percent;

    try {
      var calculator = _type == CalculationType.INCOME ? _incomeCalc : _outcomeCalc;
      setState(() {
        result = calculator.calcQuantity(sum, percent).toStringAsFixed(precision);
      });
    } on UnreachableValue {
      setState(() {
        result = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _sumController.addListener(_calc);
    _precisionController.addListener(_calc);
    _percentController.addListener(_calc);
  }

  @override
  void dispose() {
    _sumController.dispose();
    _precisionController.dispose();
    _percentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Input sum"),
            controller: _sumController,
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: false),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Input percent"),
            controller: _percentController,
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: false),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Input precision"),
            controller: _precisionController,
            keyboardType:
                TextInputType.numberWithOptions(decimal: false, signed: false),
          ),
          Text(result != null ? result : ""),
        ],
      ),
    );
  }
}

enum CalculationType { INCOME, OUTCOME }
