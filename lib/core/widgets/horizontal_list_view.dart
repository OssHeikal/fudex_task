import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';

class HorizontalListView extends StatelessWidget {
  const HorizontalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.title,
    this.padding,
    this.titleStyle,
    this.height = 120,
    this.enableScroll = true,
    this.separatorWidth = 16,
  });

  final int itemCount;
  final double height;
  final double separatorWidth;
  final String? title;
  final TextStyle? titleStyle;
  final bool enableScroll;
  final EdgeInsetsGeometry? padding;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      shrinkWrap: enableScroll ? false : true,
      scrollDirection: Axis.horizontal,
      physics: enableScroll ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
      padding: padding ?? EdgeInsets.symmetric(horizontal: AppSize.screenPadding),
      separatorBuilder: (_, __) => separatorWidth.w.horizontalSpace,
      itemBuilder: itemBuilder,
    ).withHeight(height.h).setTitle(
          title: title,
          gap: 8.h,
          titlePadding: AppSize.screenPadding,
          titleStyle: titleStyle ?? context.titleLarge.regular.s14.setHeight(2),
        );
  }
}
