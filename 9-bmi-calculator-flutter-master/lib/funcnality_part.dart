import 'dart:math';


class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});
  final int height;
  final int weight;

  double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);

    return _bmi.toStringAsFixed(2);
  }

  String getresult() {
    if (_bmi >= 24.9) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'UnderWeight';
    }
  }
  String getdetailed(){
      if (_bmi >= 25) {
      return 'BMI >25 kg/cm2 is Over Weight';
    } else if (_bmi > 18.5) {
      return 'BMI <18.5<24.9 is Normal';
    } else {
      return 'BMI<18.5 is Under Weight';
    }
  }
  String getInterpretation(){
      if (_bmi >= 25) {
      return 'You have a higher than normal body weight,try to exercise more';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight,Good job!';
    } else {
      return 'You have a lower than normal body weight,You can eat a bit more';
    }
  }
}
