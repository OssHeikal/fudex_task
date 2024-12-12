import 'dart:io';

import 'package:fudex/core/extensions/all_extensions.dart';

class Validator {
  static String? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateFile(
    File? value, {
    bool isRequired = true,
    String? message,
    String? title,
    int maxFileSize = 2,
  }) {
    if (value == null || value.path.isEmpty) {
      return message ?? 'You must select a file';
    } else if (value.lengthSync().bytesToMegaBytes > maxFileSize) {
      return message ?? 'File size must be less than $maxFileSize MB';
    }
    return null;
  }
}
