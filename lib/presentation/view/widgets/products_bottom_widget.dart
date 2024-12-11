import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/resources/resources.dart';
import 'package:fudex/core/widgets/custom_input_field.dart';
import 'package:fudex/core/widgets/custom_selectable_list.dart';
import 'package:fudex/presentation/controller/categories/categories_cubit.dart';
import 'package:fudex/presentation/controller/products/products_cubit.dart';

class ProductsBottomWidget extends HookWidget {
  const ProductsBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();

    final searchController = useTextEditingController();
    final selectedCategory = useState<int?>(null);

    void fetchProducts() => cubit.getProducts(search: searchController.text, categoryId: selectedCategory.value);

    useEffect(() {
      searchController.addListener(fetchProducts);
      return () => searchController.removeListener(fetchProducts);
    }, [searchController]);

    useEffect(() {
      fetchProducts();
      return null;
    }, [selectedCategory.value]);

    return Column(
      children: [
        CustomInputField.search(
          controller: searchController,
          hint: 'Search product (eg. Bag, Sneakers, ...) ',
        ).paddingHorizontal(AppSize.screenPadding),
        14.gap,
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            return CustomSelectableList(
              items: state.mainCategories,
              itemAsString: (category) => category?.name ?? '',
              onSelected: (value) => selectedCategory.value = value?.id,
            );
          },
        ),
      ],
    );
  }
}
