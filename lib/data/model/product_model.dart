import 'package:equatable/equatable.dart';
import 'package:fudex/data/model/addon_model.dart';

import '../../core/resources/enums/products_status_enum.dart';
import 'category_model.dart';

List<ProductModel> productModelFromJson(dynamic json, String? search, int? categoryId) {
  final products = (json['data'] as List).map((e) => ProductModel.fromJson(e));
  return products.where((product) {
    final matchesSearch = search == null || product.name.toLowerCase().contains(search.toLowerCase());
    final matchesCategory = categoryId == null || product.mainCategory.id == categoryId;
    return matchesSearch && matchesCategory;
  }).toList();
}

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final num price;
  final String mainImage;
  final List<String> secondaryImages;
  final List<AddonModel> addOns;
  final CategoryModel mainCategory;
  final CategoryModel subcategory;
  final ProductsStatus status;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.mainImage,
    required this.secondaryImages,
    required this.addOns,
    required this.mainCategory,
    required this.subcategory,
    required this.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as num,
      mainImage: json['mainImage'] as String,
      secondaryImages: List<String>.from(json['secondaryImages'] as List),
      addOns: List<AddonModel>.from(json['addOns'].map((x) => AddonModel.fromJson(x))),
      mainCategory: CategoryModel.fromJson(json['mainCategory']),
      subcategory: CategoryModel.fromJson(json['subCategory']),
      status: ProductsStatus.fromString(json['status'] as String),
    );
  }

  const ProductModel.empty()
      : id = 0,
        name = '',
        description = '',
        price = 0.0,
        mainImage = '',
        secondaryImages = const [],
        addOns = const [],
        mainCategory = const CategoryModel.empty(),
        subcategory = const CategoryModel.empty(),
        status = ProductsStatus.inactive;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        mainImage,
        secondaryImages,
        addOns,
        mainCategory,
        subcategory,
        status,
      ];
}
