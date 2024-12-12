import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/resources/resources.dart';
import 'package:fudex/core/utils/toaster_utils.dart';
import 'package:fudex/core/widgets/custom_delete_button.dart';
import 'package:fudex/core/widgets/custom_image.dart';
import 'package:fudex/core/widgets/custom_switch_field.dart';
import 'package:fudex/data/model/product_model.dart';
import 'package:fudex/presentation/controller/products/products_cubit.dart';
import 'package:fudex/presentation/view/widgets/add_on_options_list.dart';

import '../screens/product_details_screen.dart';

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
            if (product.mainImage.startsWith("http"))
              CustomImage(
                imageUrl: product.mainImage,
                width: 90.r,
                height: 90.r,
                fit: BoxFit.cover,
                borderRadius: 4.borderRadius,
              )
            else
              Image.file(
                File(product.mainImage),
                width: 90.r,
                height: 90.r,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ).clipRRect(6),
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
    )
        .setInkContainerToView(
          radius: 6.r,
          shadows: ShadowStyles.cardShadow,
          color: context.scaffoldBackgroundColor,
        )
        .onTap(() => context.push(ProductDetailsScreen(product: product)));
  }
}
