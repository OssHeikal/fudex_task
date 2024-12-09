import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key, this.center = true});
  final bool center;

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.close)
        .setContainerToView(borderColor: context.primaryContainerColor, radius: 6.r, padding: 4.r)
        .onTap(() => context.pop(), borderRadius: 6.borderRadius)
        .center(enabled: center);
  }
}
