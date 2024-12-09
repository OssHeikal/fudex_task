import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';
import '../theme/light_theme.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({super.key, required this.isError, required this.text});

  final bool isError;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color color = isError ? LightThemeColors.error : LightThemeColors.success;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14).w,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30).r),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isError ? Icons.warning : Icons.done, color: Colors.white, size: 20),
          8.gap,
          Text(
            text,
            maxLines: 2,
            style: TextStylesManager.font.s14.medium.setColor(Colors.white),
          ).fit(alignment: Alignment.center).flexible()
        ],
      ),
    ).paddingHorizontal(AppSize.screenPadding);
  }
}
