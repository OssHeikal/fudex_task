import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/resources/resources.dart';
import 'package:fudex/core/utils/toaster_utils.dart';
import 'package:fudex/core/widgets/custom_app_bar.dart';
import 'package:fudex/core/widgets/custom_button.dart';
import 'package:fudex/core/widgets/custom_delete_button.dart';
import 'package:fudex/core/widgets/custom_switch_field.dart';
import 'package:fudex/core/widgets/vertical_list_view.dart';
import 'package:fudex/data/model/product_model.dart';
import 'package:fudex/presentation/controller/products/products_cubit.dart';

import '../../../core/widgets/custom_image.dart';
import '../../../data/model/addon_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) => state.deleteStatus.listen(
        onSuccess: () => Toaster.showToast("Product deleted successfully", isError: false),
      ),
      child: Scaffold(
        appBar: CustomAppBar.build(titleText: 'Products', removeBack: true),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: 'Add Product',
              onPressed: () {},
            )
                .withSafeArea(minimum: AppSize.screenPadding.edgeInsetsHorizontal)
                .paddingTop(24)
                .setContainerToView(color: context.scaffoldBackgroundColor, shadows: ShadowStyles.bottomSheetShadow),
          ],
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            return state.status.build(
              onSuccess: VerticalListView(
                padding: AppSize.screenPadding.edgeInsetsAll,
                itemCount: state.products.length,
                itemBuilder: (context, index) => ProductTile(product: state.products[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final addonslength = product.addOns.length > 2 ? 2 : product.addOns.length;
    return Column(
      children: [
        Row(
          children: [
            CustomSwitchField(
              value: true,
              title: "status",
              onChanged: (value) {
                if (value) {
                  Toaster.showToast("Product is active", isError: false);
                } else {
                  Toaster.showToast("Product is inactive", isError: false);
                }
              },
            ).expand(),
            CustomDeleteButton(
              onDeleted: () => context.read<ProductsCubit>().removeProduct(product.id),
            ),
          ],
        ).paddingAll(16),
        const Divider(height: 0),
        Row(
          children: [
            CustomImage(
              imageUrl: product.mainImage,
              width: 90.r,
              height: 90.r,
              fit: BoxFit.cover,
              borderRadius: 4.borderRadius,
            ),
            12.gap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: context.bodyLarge.s16),
                Text(product.price.toDouble().formattedPrice(), style: context.titleMedium.s12.bold),
                8.gap,
                Column(
                  children: List.generate(addonslength, (index) {
                    return AddOnOptionsList(addon: product.addOns[index]).paddingBottom(8.sp);
                  }),
                ),
              ],
            ).expand(),
          ],
        ).paddingAll(16.sp),
      ],
    ).setInkContainerToView(
      radius: 6.r,
      shadows: ShadowStyles.cardShadow,
      color: context.scaffoldBackgroundColor,
    );
  }
}

class AddOnOptionsList extends StatelessWidget {
  const AddOnOptionsList({super.key, required this.addon});
  final AddonModel addon;

  @override
  Widget build(BuildContext context) {
    if (addon.inputType.isColor) {
      return Row(
        children: List.generate(addon.options.length, (index) {
          return Container(
            width: 16.r,
            height: 16.r,
            decoration: BoxDecoration(color: addon.options[index].toColor(), borderRadius: 4.borderRadius),
          ).paddingEnd(4.sp);
        }),
      );
    } else {
      return Row(
        children: List.generate(addon.options.length, (index) {
          return Text(addon.options[index], style: context.labelLarge.s12.medium.setHeight(1))
              .paddingTop(4)
              .setContainerToView(
                padding: 4,
                radius: 4.r,
                borderColor: context.labelSmall.color,
                color: context.scaffoldBackgroundColor,
              )
              .paddingEnd(4.sp);
        }),
      );
    }
  }
}
