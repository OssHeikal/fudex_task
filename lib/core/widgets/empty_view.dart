import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/widgets/custom_button.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.buttonLabel,
    this.onButtonPressed,
    this.padding = 52,
  });

  final Widget icon;
  final String title;
  final String? subtitle;
  final String? buttonLabel;
  final Function()? onButtonPressed;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        16.gap,
        Text(title, style: context.bodyLarge.s16.medium, textAlign: TextAlign.center).center(),
        if (subtitle != null)
          Text(
            subtitle!,
            style: context.labelLarge.s14.regular,
            textAlign: TextAlign.center,
          ).center().paddingTop(4),
        if (buttonLabel != null) ...[
          32.gap,
          CustomButton(
            label: buttonLabel!,
            onPressed: onButtonPressed ?? () {},
          ),
        ]
      ],
    ).paddingHorizontal(padding.sp).center();
  }
}
