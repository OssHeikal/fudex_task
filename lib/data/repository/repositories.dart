import 'package:fudex/data/model/addon_model.dart';
import 'package:fudex/data/model/category_model.dart';
import 'package:fudex/data/model/product_model.dart';
import 'package:injectable/injectable.dart';

import '../../core/utils/error_handler.dart';
import '../datasource/datasource.dart';

abstract class Repositories {
  DataResponse<List<ProductModel>> getProducts();
  DataResponse<List<CategoryModel>> getMainCategories();
  DataResponse<List<CategoryModel>> getSubCategories(int id);
  DataResponse<List<AddonModel>> getAddOns();
}

@LazySingleton(as: Repositories)
class RepositoriesImpl implements Repositories {
  final Datasource datasource;

  RepositoriesImpl(this.datasource);

  @override
  DataResponse<List<ProductModel>> getProducts() async {
    return datasource.getProducts().map(productModelFromJson);
  }

  @override
  DataResponse<List<CategoryModel>> getMainCategories() async {
    return datasource.getMainCategories().map(categoryModelFromJson);
  }

  @override
  DataResponse<List<CategoryModel>> getSubCategories(int id) async {
    return datasource.getSubCategories().map((body) => subCategoryModelFromJson(body, id));
  }

  @override
  DataResponse<List<AddonModel>> getAddOns() async {
    return datasource.getAddOns().map(addonModelFromJson);
  }
}
