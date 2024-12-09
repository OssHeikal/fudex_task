import 'package:flutter/services.dart';

class CustomInputFormatter {
  // english letters only
  static List<TextInputFormatter> get englishLettersOnly {
    return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))];
  }

  // numbers only
  static List<TextInputFormatter> get numbersOnly {
    return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
  }

  // arabic letters only
  static List<TextInputFormatter> get arabicLettersOnly {
    return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF\s]'))];
  }

  // phone number
  static List<TextInputFormatter> get phoneNumber {
    return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\+?[1-9]\d{1,14}$'))];
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any non-digit characters
    final String filteredText = newValue.text.replaceAll(RegExp(r'[^\d+]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

// email
class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any non-digit characters
    final String filteredText = newValue.text.replaceAll(RegExp(r'[^\w@.]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class ArabicInputFormatter extends TextInputFormatter {
  final bool allowSpace;
  final bool allowNumbers;

  ArabicInputFormatter({this.allowSpace = false, this.allowNumbers = false});

  String filteredText(String text) {
    if (allowSpace && allowNumbers) {
      return text.replaceAll(RegExp(r'[^\u0600-\u06FF\s0-9]'), '');
    } else if (allowSpace) {
      return text.replaceAll(RegExp(r'[^\u0600-\u06FF\s]'), '');
    } else if (allowNumbers) {
      return text.replaceAll(RegExp(r'[^\u0600-\u06FF0-9]'), '');
    } else {
      return text.replaceAll(RegExp(r'[^\u0600-\u06FF]'), '');
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String filteredText = this.filteredText(newValue.text);

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class EnglishInputFormatter extends TextInputFormatter {
  final bool allowSpace;
  final bool allowNumbers;

  EnglishInputFormatter({this.allowSpace = false, this.allowNumbers = false});

  String filteredText(String text) {
    if (allowSpace && allowNumbers) {
      return text.replaceAll(RegExp(r'[^a-zA-Z\s0-9]'), '');
    } else if (allowSpace) {
      return text.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');
    } else if (allowNumbers) {
      return text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    } else {
      return text.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String filteredText = this.filteredText(newValue.text);

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

