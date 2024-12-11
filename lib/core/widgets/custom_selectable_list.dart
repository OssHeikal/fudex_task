import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import 'horizontal_list_view.dart';

class CustomSelectableList<T> extends StatefulWidget {
  const CustomSelectableList({
    super.key,
    this.title,
    required this.items,
    required this.onSelected,
    this.itemAsString,
  });

  final List<T> items;
  final String? title;
  final String Function(T?)? itemAsString;
  final ValueChanged<T?> onSelected;

  @override
  State<CustomSelectableList<T>> createState() => _CustomSelectableListState<T>();
}

class _CustomSelectableListState<T> extends State<CustomSelectableList<T>> {
  late ValueNotifier<int?> selectedIndex;

  @override
  void initState() {
    selectedIndex = ValueNotifier(null);
    super.initState();
  }

  void _onSelected(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null;
      widget.onSelected(null);
    } else {
      selectedIndex.value = index;
      widget.onSelected(widget.items[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: selectedIndex,
      builder: (_, index, __) {
        return HorizontalListView(
          height: 32.r,
          title: widget.title,
          separatorWidth: 8,
          itemCount: widget.items.length,
          itemBuilder: (_, index) {
            final textColor = index == selectedIndex.value ? context.scaffoldBackgroundColor : null;
            final bgColor = index == selectedIndex.value ? context.primaryColor : null;
            final borderColor = index == selectedIndex.value ? context.primaryColor : context.inputFieldBorderColor;
            return Text(
              widget.itemAsString?.call(widget.items[index]) ?? widget.items[index].toString(),
              style: context.bodySmall.regular.s14.copyWith(color: textColor),
            )
                .paddingTop(4)
                .center()
                .paddingSymmetric(20, 4)
                .setContainerToView(radius: 4, color: bgColor, borderColor: borderColor)
                .onTap(() => _onSelected(index), borderRadius: 4.0.borderRadius);
          },
        );
      },
    );
  }
}
