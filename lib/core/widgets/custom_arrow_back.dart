import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key, this.iconColor, this.onPressed});
  final Color? iconColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.arrow_back_ios, color: iconColor ?? context.iconColor, size: 20.sp)
        .paddingAll(4)
        .onTap(onPressed ?? () => context.pop(context), borderRadius: 6.r.borderRadius)
        .center()
        .rotate(angle: context.isArabic ? 180 : 0);
  }
}
