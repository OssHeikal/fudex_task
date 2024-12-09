import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';
import '../theme/light_theme.dart';

enum ButtonType { icon, svg, text }

enum ButtonSize { small, medium, large }

enum ButtonShape { rounded, stadium }

enum ButtonStyle { filled, outlined }

class CustomButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final ButtonType type;
  final ButtonSize size;
  final ButtonShape shape;
  final ButtonStyle style;
  final IconData? icon;
  final String? svg;
  final double? iconSize;
  final double? svgSize;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? fontColor;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.label = '',
    required this.onPressed,
    this.type = ButtonType.text,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.filled,
    this.icon,
    this.svg,
    this.iconSize,
    this.svgSize,
    this.width,
    this.height,
    this.fontSize,
    this.fontColor,
    this.textStyle,
    this.fontWeight,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppSize.buttonRadius,
    this.isLoading = false,
  });

  const CustomButton.icon({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.filled,
    this.iconSize,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.icon,
        svg = null,
        svgSize = null;

  const CustomButton.svg({
    super.key,
    required this.label,
    required this.onPressed,
    required this.svg,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.filled,
    this.svgSize,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.svg,
        icon = null,
        iconSize = null;

  const CustomButton.iconOutlined({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.outlined,
    this.iconSize,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor = LightThemeColors.primary,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor = LightThemeColors.primary,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.icon,
        svg = null,
        svgSize = null;

  const CustomButton.svgOutlined({
    super.key,
    required this.label,
    required this.onPressed,
    required this.svg,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.outlined,
    this.svgSize,
    this.width,
    this.height,
    this.backgroundColor = Colors.transparent,
    this.borderColor = LightThemeColors.primary,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor = LightThemeColors.primary,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.svg,
        icon = null,
        iconSize = null;

  const CustomButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.outlined,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor = LightThemeColors.primary,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor = LightThemeColors.primary,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.text,
        icon = null,
        iconSize = null,
        svg = null,
        svgSize = null;

  const CustomButton.filled({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.filled,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.text,
        icon = null,
        iconSize = null,
        svg = null,
        svgSize = null;

  const CustomButton.large({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.large,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.filled,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.text,
        icon = null,
        iconSize = null,
        svg = null,
        svgSize = null;

  const CustomButton.small({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.small,
    this.shape = ButtonShape.rounded,
    this.style = ButtonStyle.filled,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.text,
        icon = null,
        fontSize = 14,
        iconSize = null,
        svg = null,
        svgSize = null;

  const CustomButton.rounded({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.stadium,
    this.style = ButtonStyle.filled,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppSize.buttonRadius,
    this.fontColor,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.isLoading = false,
  })  : type = ButtonType.text,
        icon = null,
        iconSize = null,
        svg = null,
        svgSize = null;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        backgroundColor: _getBackgroundColor(context),
        foregroundColor: fontColor,
        minimumSize: _getButtonSize(),
        shape: _getButtonShape(style),
        textStyle: textStyle,
      ),
      child: isLoading ? const CupertinoActivityIndicator(color: Colors.white).center() : _getButtonContent(context),
    );
  }

  Size _getButtonSize() {
    switch (size) {
      case ButtonSize.small:
        return const Size(double.infinity, AppSize.buttonHeightSmall);
      case ButtonSize.medium:
        return const Size(double.infinity, AppSize.buttonHeightMedium);
      case ButtonSize.large:
        return const Size(double.infinity, AppSize.buttonHeightLarge);
      default:
        return const Size(double.infinity, AppSize.buttonHeightMedium);
    }
  }

  OutlinedBorder? _getButtonShape(ButtonStyle style) {
    switch (shape) {
      case ButtonShape.rounded:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: _getBorderColor()),
        );
      case ButtonShape.stadium:
        return StadiumBorder(side: BorderSide(color: _getBorderColor()));
    }
  }

  Widget _getButtonContent(BuildContext context) {
    switch (type) {
      case ButtonType.icon:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize ?? 16, color: fontColor),
            Text(label).paddingDirectionalOnly(start: 8, end: 8 + (iconSize ?? 8)),
          ],
        );
      case ButtonType.svg:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            SvgPicture.asset(svg!, height: svgSize?.sp, width: svgSize?.sp, color: fontColor),
            Text(label).paddingDirectionalOnly(start: 8, end: 8 + (iconSize ?? 0)),
          ],
        );
      case ButtonType.text:
        return Text(label).paddingDirectionalOnly(start: 8, end: 8 + (iconSize ?? 0));
    }
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (style) {
      case ButtonStyle.filled:
        return backgroundColor;
      case ButtonStyle.outlined:
        return context.scaffoldBackgroundColor;
    }
  }

  Color _getBorderColor() {
    switch (style) {
      case ButtonStyle.filled:
        return borderColor ?? Colors.transparent;
      case ButtonStyle.outlined:
        return borderColor ?? LightThemeColors.primary;
      default:
        return Colors.transparent;
    }
  }
}
