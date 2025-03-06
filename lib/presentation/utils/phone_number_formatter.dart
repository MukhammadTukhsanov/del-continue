import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if (!RegExp(r'^\+?\d*$').hasMatch(newText)) {
      return oldValue;
    }
    if (newText.contains('+') && newText.indexOf('+') != 0) {
      return oldValue;
    }
    if (newText.length > 13) {
      return oldValue;
    }

    return newValue;
  }
}
