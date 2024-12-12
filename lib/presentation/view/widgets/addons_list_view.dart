import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/resources/resources.dart';
import 'package:fudex/core/widgets/vertical_list_view.dart';
import 'package:fudex/data/model/addon_model.dart';
import 'package:fudex/presentation/controller/add_ons/add_ons_cubit.dart';

import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../core/widgets/custom_text_field.dart';

class AddonsListView extends HookWidget {
  const AddonsListView({
    super.key,
    this.selectedAddons,
    this.onChanged,
  });

  final List<AddonModel>? selectedAddons;
  final void Function(List<AddonModel> p1)? onChanged;

  @override
  Widget build(BuildContext context) {
    final selectedAddons = useState<List<AddonModel>>(this.selectedAddons ?? []);
    return BlocBuilder<AddOnsCubit, AddOnsState>(
      builder: (context, state) {
        return VerticalListView(
          enableScroll: false,
          padding: 0.edgeInsetsAll,
          separator: Divider(height: 16.h, indent: AppSize.screenPadding),
          itemCount: state.addons.length,
          itemBuilder: (context, index) {
            final item = state.addons[index];
            final isSelected = selectedAddons.value.contains(item);
            return Row(
              children: [
                Text(item.name, style: context.bodyMedium.s12),
                const Spacer(),
                Icon(
                  Icons.check,
                  size: 20,
                  color: context.primaryColor,
                ).visible(isSelected)
              ],
            ).paddingHorizontal(AppSize.screenPadding).onTap(() {
              final updatedList = List<AddonModel>.from(selectedAddons.value);
              if (isSelected) {
                updatedList.remove(item);
              } else {
                updatedList.add(item);
              }
              selectedAddons.value = updatedList;
              onChanged?.call(selectedAddons.value);
            });
          },
        );
      },
    );
  }
}

class AddonsField extends StatelessWidget {
  const AddonsField({
    super.key,
    this.initialAddons,
    this.onChanged,
  });
  final List<AddonModel>? initialAddons;
  final void Function(List<AddonModel>)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      hint: 'Select addons',
      title: 'Addons',
      suffixIcon: const Icon(Icons.arrow_drop_down),
      onTap: () async {
        context.showBottomSheet(
          CustomBottomSheet(
            title: 'Select Addons for Product',
            child: AddonsListView(selectedAddons: initialAddons, onChanged: onChanged).paddingBottom(16.h),
          ),
        );
      },
    );
  }
}
