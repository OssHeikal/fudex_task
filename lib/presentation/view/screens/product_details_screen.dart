import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/resources/enums/addon_type_enum.dart';
import 'package:fudex/core/service_locator/injection.dart';
import 'package:fudex/core/widgets/custom_multiple_selection_field.dart';
import 'package:fudex/core/widgets/custom_selection_field.dart';
import 'package:fudex/core/widgets/custom_text_field.dart';
import 'package:fudex/core/widgets/select_multiple_images_field.dart';
import 'package:fudex/data/model/addon_model.dart';
import 'package:fudex/data/model/category_model.dart';
import 'package:fudex/data/model/product_model.dart';
import 'package:fudex/presentation/controller/categories/categories_cubit.dart';
import 'package:fudex/presentation/view/widgets/addons_list_view.dart';

import '../../../core/resources/constants.dart';
import '../../../core/resources/enums/products_status_enum.dart';
import '../../../core/utils/toaster_utils.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../../../core/widgets/select_image_field.dart';
import '../../controller/product_details/product_details_cubit.dart';
import '../../controller/products/products_cubit.dart';

class ProductDetailsScreen extends HookWidget {
  const ProductDetailsScreen({super.key, this.product});
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final bool isEdit = product != null;
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final categoriesCubit = context.read<CategoriesCubit>();

    final nameController = useTextEditingController(text: isEdit ? product!.name : '');
    final priceController = useTextEditingController(text: isEdit ? product!.price.toString() : '');
    final descriptionController = useTextEditingController(text: isEdit ? product!.description : '');

    final selectedCategory = useState(product?.mainCategory);
    final selectedSubcategory = useState(product?.subcategory);

    final selectedAddon = useState(product?.addOns);

    final selectedAddonsOptions = useState<List<AddonModel>>([]);

    final mainImage = useState<File?>(null);
    final secondaryImages = useState<List<File?>?>(null);

    useEffect(
      () {
        if (selectedCategory.value != null) {
          selectedSubcategory.value = null;
          context.read<CategoriesCubit>().getSubCategories(selectedCategory.value!.id);
        }
        return null;
      },
      [selectedCategory.value],
    );

    return BlocProvider(
      create: (context) => sl<ProductDetailsCubit>(),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) => state.status.listen(
          onSuccess: () {
            Toaster.showToast('Product added successfully', isError: false);
            context.read<ProductsCubit>().addProduct(state.product);
            Navigator.pop(context);
          },
        ),
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar.build(titleText: isEdit ? 'Edit Product' : 'Add Product'),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  label: 'Save',
                  onPressed: () {
                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      final newProduct = ProductModel(
                        id: Random().nextInt(1000),
                        name: nameController.text,
                        mainImage: mainImage.value?.path ?? '',
                        secondaryImages: secondaryImages.value?.map((e) => e?.path ?? '').toList() ?? [],
                        status: ProductsStatus.active,
                        price: double.parse(priceController.text),
                        description: descriptionController.text,
                        mainCategory: selectedCategory.value!,
                        subcategory: selectedSubcategory.value!,
                        addOns: selectedAddonsOptions.value,
                      );
                      context.read<ProductDetailsCubit>().addProduct(newProduct);
                    }
                  },
                ).setHero(AppConstants.mainButtonTag),
              ],
            ).toBottomNavBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomImagesSelection(
                    images: product?.secondaryImages,
                    mainImageUrl: product?.mainImage,
                    onImageSelected: (file) => mainImage.value = file,
                    onImagesSelected: (images) => secondaryImages.value = images,
                  ),
                  16.gap,
                  CustomTextField(
                    isRequired: true,
                    controller: nameController,
                    hint: 'Enter product name',
                    title: 'Product Name',
                  ),
                  16.gap,
                  CustomTextField(
                    isRequired: true,
                    controller: priceController,
                    hint: 'Enter product price',
                    title: 'Product Price',
                    inputType: InputType.price,
                  ),
                  16.gap,
                  CustomTextField(
                    maxLines: 5,
                    isRequired: true,
                    title: 'Product Description',
                    hint: 'Enter product description',
                    controller: descriptionController,
                  ),
                  16.gap,
                  CustomSelectionField<CategoryModel>(
                    title: 'Main Category',
                    hint: 'Select main category',
                    initialValue: selectedCategory.value,
                    items: categoriesCubit.state.mainCategories,
                    itemToString: (category) => category?.name ?? '',
                    validator: (_) => selectedCategory.value == null ? 'Please select a main category' : null,
                    onChanged: (value) => selectedCategory.value = value,
                  ),
                  16.gap,
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      return CustomSelectionField<CategoryModel>(
                        items: categoriesCubit.state.subCategories,
                        hint: 'Select sub category',
                        title: 'Subcategory',
                        itemToString: (category) => category?.name ?? '',
                        initialValue: selectedSubcategory.value,
                        onChanged: (value) => selectedSubcategory.value = value,
                        validator: (_) => selectedSubcategory.value == null ? 'Please select a subcategory' : null,
                      );
                    },
                  ).visible(selectedCategory.value != null),
                  16.gap.visible(selectedCategory.value != null),
                  AddonsField(initialAddons: selectedAddon.value, onChanged: (value) => selectedAddon.value = value),
                  if (selectedAddon.value != null) ...[
                    16.gap,
                    ...selectedAddon.value!.map((addon) {
                      final List<String>? selectedOptions = selectedAddonsOptions.value
                          .firstWhereOrNull((element) => element.name == addon.name)
                          ?.options;
                      return CustomMultipleSelectionField<String>(
                        title: addon.name,
                        items: addon.options,
                        itemBuilder: (context, item) {
                          if (addon.inputType == AddonInputType.colorPicker) {
                            return Container(
                              width: 32,
                              height: 24,
                              margin: 4.edgeInsetsAll,
                              decoration: BoxDecoration(color: item!.toColor(), borderRadius: BorderRadius.circular(4)),
                            ).paddingRight(8);
                          }
                          return Text(item.toString()).paddingTop(4);
                        },
                        initialItems: selectedOptions,
                        onChanged: (value) {
                          final newAddon = AddonModel(name: addon.name, options: value, inputType: addon.inputType);
                          final updatedList = List<AddonModel>.from(selectedAddonsOptions.value);
                          final index = updatedList.indexWhere((element) => element.name == addon.name);
                          if (index == -1) {
                            updatedList.add(newAddon);
                          } else {
                            updatedList[index] = newAddon;
                          }
                          selectedAddonsOptions.value = updatedList;
                        },
                      ).paddingBottom(16.h);
                    })
                  ],
                ],
              ),
            ).withListView(key: const ValueKey('product_details_screen')),
          );
        },
      ),
    );
  }
}

class CustomImagesSelection extends StatelessWidget {
  const CustomImagesSelection({
    super.key,
    this.images,
    this.mainImageUrl,
    this.onImageSelected,
    this.onImagesSelected,
  });

  final List<String>? images;
  final String? mainImageUrl;
  final void Function(File?)? onImageSelected;
  final void Function(List<File?>?)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectImageField(
          imageUrl: mainImageUrl,
          onImageSelected: (file) {
            onImageSelected?.call(file);
          },
        ),
        16.gap,
        SelectMultipleImagesField(
          onImagesSelected: (images) {
            onImagesSelected?.call(images);
          },
        ),
      ],
    ).withDottedBorder(padding: 16.edgeInsetsAll);
  }
}
