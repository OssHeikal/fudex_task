import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Double Extensions
extension DoubleExtensions on double? {
  /// Validate given double is not null and returns given value if null.
  double validate({double value = 0.0}) => this ?? value;

  /// 100.0.isBetween(50.0, 150.0) // true;
  bool isBetween(num first, num second) {
    final lower = min(first, second);
    final upper = max(first, second);
    // ignore: unnecessary_this
    return this.validate() >= lower && this.validate() <= upper;
  }

  /// Returns Size
  Size get size => Size(this!, this!);

  /// Leaves given height of space
  Widget get height => this!.verticalSpace;

  /// Leaves given width of space
  Widget get width => this!.horizontalSpace;



}
