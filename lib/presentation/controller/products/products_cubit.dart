import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/enums/cubit_status_enum.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repository/repositories.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final Repository _repository;
  ProductsCubit(this._repository) : super(const ProductsState()) {
    _getProducts();
  }

  void _getProducts() async {
    emit(state.copyWith(status: CubitStatus.loading));
    final response = await _repository.getProducts();
    response.fold(
      (failure) => emit(state.copyWith(status: CubitStatus.failed, message: failure.message)),
      (data) => emit(state.copyWith(status: CubitStatus.success, products: data)),
    );
  }

  void addProduct(ProductModel product) {
    final List<ProductModel> products = state.products;
    products.add(product);
    emit(state.copyWith(products: products));
  }

  void removeProduct(int productId) {
    emit(state.copyWith(deleteStatus: CubitStatus.loading));
    final List<ProductModel> products = state.products;
    products.removeWhere((element) => element.id == productId);
    emit(state.copyWith(products: products, deleteStatus: CubitStatus.success));
  }
}
