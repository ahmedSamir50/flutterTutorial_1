import 'dart:math';

class BMIStateModel {
  int clientHeight = 50;

  int clientAge = 18;
  int clientWight = 60;
  ClientGender clientGender = ClientGender.MALE;

  double clientBMI() => (clientWight / pow((clientHeight / 100), 2));

  String bmiState() {
    var bmi = clientBMI();
    BMIIndicator index = BMIIndicator.OVERWIGHT;
    bmi < 18.5
        ? index = BMIIndicator.OVERWIGHT
        : bmi < 24.9
            ? index = BMIIndicator.HEALTHY
            : bmi < 29.9
                ? index = BMIIndicator.OVERWIGHT
                : bmi < 29.9
                    ? index = BMIIndicator.OBESE
                    : index = BMIIndicator.UNKNOWN;

    return index.toString();
  }
}

enum ClientGender { MALE, FEMALE }
enum BMIIndicator { UNDERWIGHT, HEALTHY, OVERWIGHT, OBESE, UNKNOWN }
