import 'package:intl/intl.dart';

const _vietnamese = 'aAeEoOuUiIdDyY';

class StringHelper {
  static String convertTemp(num temp) {
    double convertedNumber = temp / 10;
    final formattedString = convertedNumber.toString().replaceAll('.', ',');
    return formattedString;
  }

  static String convertDateTime() {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, d MMM').format(now);
    return formattedDate;
  }
}
