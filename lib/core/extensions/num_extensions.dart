import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/main.dart';
import 'package:intl/intl.dart';

extension NumExt on num? {
  num validate({num defaultValue = 0}) {
    if (this == null) {
      return defaultValue;
    }
    return this!;
  }

  SizedBox get gap => SizedBox(height: validate().toDouble().h, width: validate().toDouble().w);

  /// Converts the value of this [double] to radians.
  ///
  /// Returns the value of this [double] in radians by multiplying it with the conversion factor `pi / 180.0`.
  double get toRadians => validate().toDouble() * (pi / 180.0);

  EdgeInsets get edgeInsetsHorizontal => EdgeInsets.symmetric(horizontal: validate().toDouble());

  EdgeInsets get edgeInsetsVertical => EdgeInsets.symmetric(vertical: validate().toDouble());

  EdgeInsets get edgeInsetsAll => EdgeInsets.all(validate().toDouble());

  EdgeInsets get edgeInsetsOnlyTop => EdgeInsets.only(top: validate().toDouble());

  EdgeInsets get edgeInsetsOnlyBottom => EdgeInsets.only(bottom: validate().toDouble());

  EdgeInsets get edgeInsetsOnlyLeft => EdgeInsets.only(left: validate().toDouble());

  EdgeInsets get edgeInsetsOnlyRight => EdgeInsets.only(right: validate().toDouble());

  BorderRadius get borderRadius => BorderRadius.circular(validate().toDouble());

  BorderRadius get leftBorderRadius => BorderRadius.only(
        topLeft: Radius.circular(validate().toDouble()),
        bottomLeft: Radius.circular(validate().toDouble()),
      );

  BorderRadius get rightBorderRadius => BorderRadius.only(
        topRight: Radius.circular(validate().toDouble()),
        bottomRight: Radius.circular(validate().toDouble()),
      );

  BorderRadius get topBorderRadius => BorderRadius.only(
        topLeft: Radius.circular(validate().toDouble()),
        topRight: Radius.circular(validate().toDouble()),
      );

  BorderRadius get bottomBorderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(validate().toDouble()),
        bottomRight: Radius.circular(validate().toDouble()),
      );

  Radius get radius => Radius.circular(validate().toDouble());

  /// Formats the price as a string with the specified currency and decimal digits.
  ///
  /// Example:
  /// ```dart
  /// 1000.0.formattedPrice() // SAR 1,000
  /// 1000.0.formattedPrice(currency: 'USD', decimalDigits: 2) // USD 1,000.00
  /// ````\
  String formattedPrice({String? currency, int decimalDigits = 0}) {
    currency ??= 'SAR';
    final context = rootNavigatorKey.currentContext!;
    final Locale locale = Localizations.localeOf(context);
    return NumberFormat.currency(
      name: '$currency ',
      decimalDigits: decimalDigits,
      locale: locale.languageCode,
    ).format(validate());
  }
}
