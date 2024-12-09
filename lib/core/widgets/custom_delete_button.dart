import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/widgets/custom_dialog.dart';

class CustomDeleteButton extends StatelessWidget {
  const CustomDeleteButton({super.key, this.onDeleted, this.deleteLabel, this.title});

  final void Function()? onDeleted;
  final String? deleteLabel;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Icon(CupertinoIcons.trash, color: context.errorColor, size: 16).paddingAll(4).onTap(() {
      context.showDialog(
        CustomDialog(
          isDestructive: true,
          onConfirm: onDeleted,
          title: title ?? 'Are you sure you want to delete this item?',
          confirmLabel: deleteLabel ?? 'Delete',
        ),
      );
    });
  }
}
