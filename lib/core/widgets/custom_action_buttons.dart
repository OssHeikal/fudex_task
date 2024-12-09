import 'package:flutter/material.dart';

import '../extensions/all_extensions.dart';
import 'custom_button.dart';

class CustomActionButtons extends StatelessWidget {
  const CustomActionButtons({
    super.key,
    this.onConfirm,
    this.onCancel,
    this.confirmLabel,
    this.cancelLabel,
    this.showConfirm = true,
    this.confirmColor,
    this.isLoading = false,
  });

  final void Function()? onConfirm;
  final void Function()? onCancel;
  final String? confirmLabel;
  final String? cancelLabel;
  final bool showConfirm;
  final Color? confirmColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton.outlined(
          borderColor: context.iconColorDisabled,
          fontColor: context.iconColorDisabled,
          label: cancelLabel ?? "cancel",
          onPressed: () {
            Navigator.of(context).pop();
            onCancel?.call();
          },
        ).flexible(),
        if (showConfirm) ...[
          16.gap,
          CustomButton(
            isLoading: isLoading,
            backgroundColor: confirmColor,
            label: confirmLabel ?? 'confirm',
            onPressed: onConfirm ?? () => Navigator.of(context).pop(),
          ).flexible(),
        ],
      ],
    );
  }
}
