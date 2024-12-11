import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/data/model/addon_model.dart';

class AddOnOptionsList extends StatelessWidget {
  const AddOnOptionsList({super.key, required this.addon});
  final AddonModel addon;

  @override
  Widget build(BuildContext context) {
    if (addon.inputType.isColor) {
      return Row(
        children: List.generate(addon.options.length, (index) {
          return Container(
            width: 16.r,
            height: 16.r,
            decoration: BoxDecoration(color: addon.options[index].toColor(), borderRadius: 4.borderRadius),
          ).paddingEnd(4.sp);
        }),
      );
    } else {
      return Row(
        children: List.generate(addon.options.length, (index) {
          return Text(addon.options[index], style: context.labelLarge.s12.medium.setHeight(1))
              .paddingTop(4)
              .setContainerToView(
                padding: 4,
                radius: 4.r,
                borderColor: context.labelSmall.color,
                color: context.scaffoldBackgroundColor,
              )
              .paddingEnd(4.sp);
        }),
      );
    }
  }
}
