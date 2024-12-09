import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../../main.dart';
import 'custom_arrow_back.dart';
import 'custom_search_field.dart';

class CustomAppBar {
  static AppBar build({
    String? titleText,
    TextStyle? titleStyle,
    Widget? title,
    Widget? leading,
    double leadingWidth = 70,
    List<Widget>? actions,
    bool removeBack = false,
    bool centerTitle = true,
    Color? backgroundColor,
    Color? iconColor,
    Widget? bottom,
    double bottomHeight = 40,
    double height = kToolbarHeight,
  }) {
    final context = rootNavigatorKey.currentContext!;
    return AppBar(
      toolbarHeight: height,
      titleTextStyle: titleStyle ?? context.bodyLarge.bold.s16,
      iconTheme: context.iconTheme!.copyWith(color: iconColor),
      backgroundColor: backgroundColor,
      leadingWidth: leadingWidth.sp,
      centerTitle: centerTitle,
      automaticallyImplyLeading: removeBack == true ? false : true,
      leading: leading ?? (removeBack ? null : const CustomArrowBack()),
      title: title ?? Text(titleText ?? ''),
      actions: actions,
      bottom: bottom != null ? PreferredSize(preferredSize: Size.fromHeight(bottomHeight.h), child: bottom) : null,
    );
  }

  static AppBar search(
    BuildContext context, {
    void Function(String)? onChanged,
    Widget? bottom,
    String? hintText,
    double bottomHeight = 40,
    void Function()? onFilter,
  }) {
    return AppBar(
      toolbarHeight: 90.h,
      title: CustomSearchField(onChanged: onChanged, hintText: hintText, onFilter: onFilter),
      bottom: bottom != null ? PreferredSize(preferredSize: Size.fromHeight(bottomHeight.h), child: bottom) : null,
    );
  }
}
