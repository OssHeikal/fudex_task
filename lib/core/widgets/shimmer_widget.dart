import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.shapeBorder,
    required this.radius,
  });

  final double width;
  final double height;
  final double borderRadius;
  final double radius;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.circular({
    super.key,
    required this.radius,
  })  : width = radius,
        height = radius,
        borderRadius = radius,
        shapeBorder = const CircleBorder();

  const ShimmerWidget.rectangular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppSize.mainRadius,
    this.shapeBorder = const RoundedRectangleBorder(),
  }) : radius = borderRadius;
  // shapeBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(color: Colors.grey.withOpacity(0.25), shape: shapeBorder),
    ).withShimmer();
  }
}
