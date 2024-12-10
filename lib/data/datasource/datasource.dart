import 'package:flutter/services.dart';
import 'package:fudex/core/resources/constants.dart';
import 'package:injectable/injectable.dart';

abstract class Datasource {
  Future<dynamic> getProducts();
  Future<dynamic> getMainCategories();
  Future<dynamic> getSubCategories();
  Future<dynamic> getAddOns();
}

@LazySingleton(as: Datasource)
class DatasourceImpl implements Datasource {
  @override
  Future<dynamic> getProducts() async => await rootBundle.loadString(AppConstants.products);

  @override
  Future<dynamic> getMainCategories() async => await rootBundle.loadString(AppConstants.mainCategories);

  @override
  Future<dynamic> getSubCategories() async => await rootBundle.loadString(AppConstants.subCategories);

  @override
  Future<dynamic> getAddOns() async => await rootBundle.loadString(AppConstants.addOns);
}
