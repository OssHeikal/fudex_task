import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/widgets/custom_bottom_sheet.dart';
import 'package:fudex/core/widgets/custom_text_field.dart';

import '../resources/resources.dart';
import 'vertical_list_view.dart';

class CustomMultipleSelectionField<T> extends HookWidget {
  const CustomMultipleSelectionField({
    super.key,
    this.title,
    this.onChanged,
    this.initialItems,
    required this.items,
    this.itemBuilder,
  });

  final List<T> items;
  final String? title;
  final List<T>? initialItems;
  final void Function(List<T>)? onChanged;
  final Widget Function(BuildContext, T?)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    final selectedItems = useState<List<T>>(initialItems ?? []);

    useEffect(() {
      selectedItems.value = initialItems ?? [];
      return null;
    }, [initialItems]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          readOnly: true,
          hint: 'Select options',
          title: title,
          suffixIcon: const Icon(Icons.arrow_drop_down),
          onTap: () async {
            List<T> selectedOptions = initialItems ?? [];
            await context.showBottomSheet(
              CustomBottomSheet(
                title: 'Select Addons for Product',
                child: OptionsListView(
                  items: items,
                  initialOptions: selectedItems.value,
                  itemBuilder: itemBuilder,
                  onChanged: (value) {
                    selectedOptions = value;
                    onChanged?.call(selectedOptions);
                  },
                ).paddingBottom(16.h),
              ),
            );
            // selectedItems.value = selectedOptions;
            onChanged?.call(selectedOptions);
          },
        ),
        if (selectedItems.value.isNotEmpty) ...[
          16.gap,
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: selectedItems.value.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  itemBuilder?.call(context, item) ?? Text(item.toString(), style: context.bodyMedium.s12),
                  12.gap,
                  Icon(
                    CupertinoIcons.trash,
                    size: 12,
                    color: context.errorColor,
                  ).circle(radius: 10).onTap(() {
                    final updatedList = List<T>.from(selectedItems.value);
                    updatedList.remove(item);
                    selectedItems.value = updatedList;
                    onChanged?.call(selectedItems.value);
                  }),
                ],
              ).setContainerToView(
                radius: 100,
                padding: 6,
                color: context.primaryColor.withOpacity(0.1),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class OptionsListView<T> extends HookWidget {
  const OptionsListView({
    super.key,
    required this.items,
    this.onChanged,
    this.initialOptions,
    this.itemBuilder,
  });

  final List<T> items;
  final List<T>? initialOptions;
  final void Function(List<T>)? onChanged;
  final Widget? Function(BuildContext, T)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    final selectedOptions = useState<List<T>>(this.initialOptions ?? []);
    return VerticalListView(
      enableScroll: false,
      padding: 0.edgeInsetsAll,
      separator: Divider(height: 16.h, indent: AppSize.screenPadding),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            itemBuilder?.call(context, item) ?? Text(item.toString(), style: context.bodyMedium.s12).expand(),
            Icon(
              Icons.check,
              size: 20,
              color: context.primaryColor,
            ).visible(selectedOptions.value.contains(item))
          ],
        ).paddingHorizontal(AppSize.screenPadding).onTap(() {
          final updatedList = List<T>.from(selectedOptions.value);
          if (updatedList.contains(item)) {
            updatedList.remove(item);
          } else {
            updatedList.add(item);
          }
          selectedOptions.value = updatedList;
          onChanged?.call(selectedOptions.value);
        });
      },
    );
  }
}
