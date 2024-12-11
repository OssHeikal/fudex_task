import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/resources/resources.dart';
import 'package:fudex/core/utils/toaster_utils.dart';
import 'package:fudex/core/widgets/custom_app_bar.dart';
import 'package:fudex/core/widgets/custom_button.dart';
import 'package:fudex/core/widgets/empty_view.dart';
import 'package:fudex/core/widgets/vertical_list_view.dart';
import 'package:fudex/presentation/controller/products/products_cubit.dart';
import 'package:fudex/presentation/view/widgets/product_tile.dart';
import 'package:fudex/presentation/view/widgets/products_bottom_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) => state.deleteStatus.listen(
        onSuccess: () => Toaster.showToast("Product deleted successfully", isError: false),
      ),
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar.build(
            bottomHeight: 100,
            removeBack: true,
            titleText: 'Products',
            bottom: const ProductsBottomWidget().paddingBottom(8),
          ),
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
                ).visible(
                  state.products.isNotEmpty,
                  fallback: EmptyView(
                    icon: Icon(Icons.search_off_rounded, size: 72, color: context.disabledButtonColor),
                    title: 'Result Not Found',
                    subtitle: 'No products found for your search, try again with different keywords.',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
