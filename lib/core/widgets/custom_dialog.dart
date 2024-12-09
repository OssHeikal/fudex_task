import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';
import 'custom_button.dart';
import 'custom_close_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    this.confirmLabel,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    this.confirmColor,
    this.showConfirm = true,
    this.isDestructive = false,
  });
  final String title;
  final String? confirmLabel;
  final String? cancelLabel;
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final Color? confirmColor;
  final bool showConfirm;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomCloseButton(center: false),
            18.verticalSpace,
            Text(title, style: context.bodyLarge.medium.s16),
            32.verticalSpace,
            if (showConfirm) ...[
              CustomButton(
                borderColor: _confirmBorderColor(context),
                fontColor: _confirmTextColor(context),
                backgroundColor: confirmColor ?? _confirmBackgroundColor(context),
                label: confirmLabel ?? "confirm",
                onPressed: () {
                  context.pop();
                  onConfirm?.call();
                },
              ),
              16.verticalSpace,
            ],
            CustomButton.outlined(
              borderColor: context.iconColorDisabled,
              fontColor: context.iconColorDisabled,
              label: cancelLabel ?? "cancel",
              onPressed: () {
                context.pop();
                onCancel?.call();
              },
            )
          ],
        )
            .setContainerToView(
              padding: AppSize.screenPadding,
              color: context.scaffoldBackgroundColor,
              radius: 6.r,
            )
            .paddingHorizontal(36)
      ],
    ).center();
  }

  Color _confirmBorderColor(BuildContext context) {
    if (isDestructive) {
      return context.errorColor;
    }
    return context.primaryColor;
  }

  Color? _confirmTextColor(BuildContext context) {
    if (isDestructive) {
      return context.errorColor;
    }
    return null;
  }

  Color _confirmBackgroundColor(BuildContext context) {
    if (isDestructive) {
      return context.errorContainerColor;
    }
    return context.primaryColor;
  }
}
