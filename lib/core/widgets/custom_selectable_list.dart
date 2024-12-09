import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import 'horizontal_list_view.dart';

class CustomSelectableList extends StatefulWidget {
  const CustomSelectableList({
    super.key,
    required this.items,
    required this.title,
    required this.onSelected,
  });

  final List<String> items;
  final String title;
  final ValueChanged<String> onSelected;

  @override
  State<CustomSelectableList> createState() => _CustomSelectableListState();
}

class _CustomSelectableListState extends State<CustomSelectableList> {
  late ValueNotifier<int?> selectedIndex;

  @override
  void initState() {
    selectedIndex = ValueNotifier(null);
    super.initState();
  }

  void _onSelected(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null;
      widget.onSelected('');
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
          height: 60.h,
          title: widget.title,
          itemCount: widget.items.length,
          itemBuilder: (_, index) {
            final textColor = index == selectedIndex.value ? context.scaffoldBackgroundColor : null;
            final bgColor = index == selectedIndex.value ? context.primaryColor : context.primaryCardColor;
            return Text(
              widget.items[index],
              style: context.titleLarge.regular.s14.copyWith(color: textColor),
            )
                .center()
                .paddingSymmetric(20, 8)
                .setContainerToView(radius: 100, color: bgColor)
                .onTap(() => _onSelected(index), borderRadius: 100.0.borderRadius);
          },
        );
      },
    );
  }
}
