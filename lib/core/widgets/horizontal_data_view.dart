import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';


class HorizontalDataView extends StatelessWidget {
  const HorizontalDataView({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.gap = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double gap;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(title, style: titleStyle ?? context.bodySmall.s12.regular),
        gap.gap,
        Text(
          subtitle,
          style: subtitleStyle ?? context.bodyMedium.s12.medium,
          overflow: TextOverflow.ellipsis,
        ).flexible(),
      ],
    );
  }
}
