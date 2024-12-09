import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';

class CustomRadioTile<T> extends StatefulWidget {
  const CustomRadioTile({
    super.key,
    this.title,
    this.icon,
    this.trailing,
    this.onChanged,
    required this.value,
    required this.groupValue,
    this.isDisabled = false,
  });

  final T value;
  final T? groupValue;
  final String? title;
  final String? icon;
  final Widget? trailing;
  final void Function(T?)? onChanged;
  final bool isDisabled;

  @override
  State<CustomRadioTile<T>> createState() => _CustomRadioTileState<T>();
}

class _CustomRadioTileState<T> extends State<CustomRadioTile<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.groupValue == widget.value;
    return Row(
      children: [
        CircleAvatar(
          radius: 10.sp,
          backgroundColor: widget.isDisabled ? context.disabledButtonColor : context.primaryColor,
          child: CircleAvatar(
            radius: isSelected ? 4.sp : 8.sp,
            backgroundColor: context.scaffoldBackgroundColor,
          ),
        ),
        8.horizontalSpace,
        if (widget.icon != null) ...[
          widget.icon.toSvg(
            color: widget.isDisabled ? context.disabledButtonColor : context.iconColor,
            height: AppSize.iconNormal,
            width: AppSize.iconNormal,
          ),
          4.horizontalSpace,
        ],
        if (widget.title != null) Text(widget.title!, style: _titleStyle),
        if (widget.trailing != null) ...[
          const Spacer(),
          widget.trailing!,
        ],
      ],
    ).setBorder( padding: 12.sp, radius: 6.sp).onTap(
        widget.isDisabled
            ? null
            : () {
                if (widget.groupValue == widget.value) {
                  widget.onChanged?.call(null);
                } else {
                  widget.onChanged?.call(widget.value);
                }
              },
        borderRadius: 6.sp.borderRadius);
  }

  TextStyle get _titleStyle {
    if (widget.isDisabled) {
      return context.titleMedium.s14.regular.copyWith(color: context.disabledButtonColor);
    } else {
      return context.titleMedium.s14.regular;
    }
  }
}
