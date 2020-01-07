import '../exceptions.dart';

abstract class QuantityCalculator {
  double calcQuantity(double amount, double percentLoss);

  bool isValueIncorrect(double value) {
    return value < 0 || value.isInfinite || value.isNaN;
  }
}

class IncomeCalculator extends QuantityCalculator {
  @override
  double calcQuantity(double amount, double percentLoss) {
    double result = amount * (1 - percentLoss / 100);
    if (isValueIncorrect(result)) throw UnreachableValue();

    return result;
  }
}

class OutcomeCalculator extends QuantityCalculator {
  @override
  double calcQuantity(double amount, double percentLoss) {
    double result = amount / (1 - percentLoss / 100);
    if (isValueIncorrect(result)) throw UnreachableValue();

    return result;
  }
}
