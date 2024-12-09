import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

class CloseIconButton extends StatelessWidget {
  const CloseIconButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.cancel, color: context.iconColorDisabled, size: 20).center().withSize(12, 12).onTap(onPressed);
  }
}
