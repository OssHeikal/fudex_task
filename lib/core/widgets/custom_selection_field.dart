import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';
import 'custom_bottom_sheet.dart';
import 'custom_loading.dart';
import 'custom_text_field.dart';
import 'vertical_list_view.dart';

class CustomSelectionField<T> extends StatefulWidget {
  const CustomSelectionField({
    super.key,
    this.title,
    this.hint,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.futureRequest,
    this.itemBuilder,
    this.itemToString,
    this.initialValue,
  });
  final String? title;
  final String? hint;
  final String? prefixIcon;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final FutureOr<List<T>> Function()? futureRequest;
  final Widget Function(BuildContext, int)? itemBuilder;
  final String Function(T?)? itemToString;
  final T? initialValue;

  @override
  State<CustomSelectionField<T>> createState() => _CustomSelectionFieldState<T>();
}

class _CustomSelectionFieldState<T> extends State<CustomSelectionField<T>> {
  late TextEditingController controller;
  late ValueNotifier<T?> _value;

  @override
  void initState() {
    _value = ValueNotifier<T?>(widget.initialValue);
    controller = TextEditingController(text: widget.itemToString?.call(widget.initialValue) ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      hint: widget.hint,
      title: widget.title,
      controller: controller,
      prefixIcon: widget.prefixIcon,
      validator: (_) => widget.validator?.call(_value.value),
      // suffixIcon: Assets.icons.dropdownArrow.svg(colorFilter: context.hintColor.colorFilter).center().withSize(20, 20),
      onTap: () async {
        context.showBottomSheet(
          CustomBottomSheet(
            title: widget.hint ?? widget.title ?? '',
            child: FutureBuilder<List<T>>(
                future: Future.value(widget.futureRequest?.call()),
                builder: (context, snapshot) {
                  final List<T> data = snapshot.data ?? [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CustomLoading().withHeight(200);
                  }
                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        'no data found',
                        style: context.bodySmall.regular.s12,
                      ).center().withHeight(200),
                    );
                  }
                  return VerticalListView(
                    enableScroll: false,
                    padding: 0.edgeInsetsAll,
                    separator: Divider(height: 16.h, indent: AppSize.screenPadding),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Row(
                        children: [
                          Text(
                            widget.itemToString?.call(item) ?? '',
                            style: context.bodyLarge.s12,
                          ),
                          const Spacer(),
                          if (_value.value == item)
                            Icon(Icons.check, size: AppSize.iconMedium, color: context.primaryColor)
                        ],
                      ).paddingHorizontal(AppSize.screenPadding).onTap(() {
                        if (item.runtimeType == T) widget.onChanged?.call(item);
                        _value.value = item;
                        controller.text = widget.itemToString?.call(item) ?? '';
                        context.pop(item);
                      });
                    },
                  ).paddingBottom(16.h);
                }),
          ),
        );
      },
    );
  }
}
