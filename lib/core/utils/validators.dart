import 'dart:io';

import 'package:fudex/core/extensions/all_extensions.dart';

class Validator {
  static String? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يجب ملء هذا الحقل';
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
      return message ?? 'يجب تحديد ملف $title';
    } else if (value.lengthSync().bytesToMegaBytes > maxFileSize) {
      return message ?? 'يجب أن يكون حجم الملف أقل من $maxFileSize ميغابايت';
    }
    return null;
  }
}
