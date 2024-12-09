import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.child, required this.title});
  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: context.bodyLarge.bold).paddingHorizontal(AppSize.screenPadding),
        16.gap,
        child,
      ],
    ).withSafeArea();
  }
}
