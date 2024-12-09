// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudex/core/extensions/all_extensions.dart';


class CustomRadioButton<T> extends StatefulWidget {
  final String name;
  final bool isSelected;
  // final ValueNotifier<T> valueNotifier;
  final T value, groupValue;
  final bool hasImage;
  final String? iconPath;
  final bool enableBorder;
  final Color? backgroundColor;
  final Function(T? v)? onChanged;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.name,
    required this.groupValue,
    // required this.valueNotifier,
    this.iconPath,
    this.backgroundColor,
    this.hasImage = false,
    this.enableBorder = false,
    this.isSelected = false,
    this.onChanged,
  });

  @override
  State<CustomRadioButton<T>> createState() => _CustomRadioButtonState<T>();
}

class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  late ValueNotifier<T?> selectedValue;

  @override
  void initState() {
    selectedValue = ValueNotifier(widget.groupValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T?>(
      valueListenable: selectedValue,
      builder: (context, currentValue, child) {
        return RadioListTile(
          value: widget.value,
          onChanged: (newValue) {
            selectedValue.value = newValue;
            widget.onChanged!(newValue);
          },
          groupValue: widget.groupValue,
          tileColor: widget.backgroundColor,
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
          activeColor: context.primaryColor,
          title: RadioButtonTitle(
              name: widget.name, hasImage: widget.hasImage, iconPath: widget.iconPath, isSelected: widget.isSelected),
        );
      },
    );
  }
}

class RadioButtonTitle extends StatelessWidget {
  const RadioButtonTitle({
    super.key,
    required this.iconPath,
    required this.isSelected,
    required this.hasImage,
    required this.name,
  });

  final String? iconPath;
  final bool isSelected;
  final bool hasImage;
  final String name;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = context.primaryColor;
    final Color unActiveColor = context.theme.hintColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (iconPath != null) ...[
          SvgPicture.asset(
            iconPath!,
            width: 24,
            color: isSelected
                ? activeColor
                : !hasImage
                    ? unActiveColor
                    : null,
          ),
          10.horizontalSpace,
        ],
        Text(
          name,
          style: isSelected
              ? context.textTheme.titleMedium!.copyWith(color: activeColor)
              : context.textTheme.bodyMedium!.copyWith(color: unActiveColor),
        ).paddingTop(4)
      ],
    );
  }
}
