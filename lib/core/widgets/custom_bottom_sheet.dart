import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.child, required this.title, this.onDone});
  final Widget child;
  final String title;
  final void Function()? onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.bodyLarge.bold),
            const Text('Done').clickable(
              onTap: onDone ?? () => Navigator.of(context).pop(),
              style: context.titleLarge.s16.bold,
            ),
          ],
        ).paddingHorizontal(AppSize.screenPadding),
        16.gap,
        child,
      ],
    ).withSafeArea();
  }
}
