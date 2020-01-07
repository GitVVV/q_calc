import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'logic/calculator.dart';
import 'exceptions.dart';


class CalculationScreen extends StatefulWidget {
  final CalculationType type;

  const CalculationScreen(this.type, {Key key}): super(key: key);

  @override
  _CalculationScreenState createState() => _CalculationScreenState(type);
}

class _CalculationScreenState extends State<CalculationScreen> {

  var _calc;

  final _sumController = TextEditingController();
  final _percentController = TextEditingController();
  final _precisionController = TextEditingController();

  String result;

  _CalculationScreenState(CalculationType type) {
    this._calc = type == CalculationType.OUTCOME ? OutcomeCalculator() : IncomeCalculator();

    _sumController.addListener(_calculate);
    _precisionController.addListener(_calculate);
    _percentController.addListener(_calculate);
  }

  void _calculate() {
    double sum = _sumController.text.isEmpty ? 0 : double.parse(_sumController.text);
    sum = sum == null ? 0 : sum;

    int precision = _precisionController.text.isEmpty ? 0 : int.parse(_precisionController.text);
    precision = precision == null ? 0 : precision;

    double percent = _percentController.text.isEmpty ? 0 : double.parse(_percentController.text);
    percent = percent == null ? 0 : percent;

    try {
      setState(() {
        result = _calc.calcQuantity(sum, percent).toStringAsFixed(precision);
      });
    } on UnreachableValue {
      setState(() {
        result = "";
      });
    }
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
        child: Padding(
          padding: EdgeInsets.all(20),
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
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                    result != null ? result : "",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

enum CalculationType { INCOME, OUTCOME }
