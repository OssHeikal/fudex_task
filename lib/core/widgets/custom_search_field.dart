import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, this.onChanged, this.hintText, this.onFilter});

  final void Function(String)? onChanged;
  final String? hintText;
  final void Function()? onFilter;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: Icon(CupertinoIcons.search, color: context.hintColor).paddingAll(4),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: 10.borderRadius)),
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(context.primaryCardColor),
      onChanged: onChanged,
      constraints: BoxConstraints(minHeight: 55.h),
      hintText: hintText ?? 'Search...',
      hintStyle: WidgetStateProperty.all(context.hintTextStyle),
    );
  }
}
