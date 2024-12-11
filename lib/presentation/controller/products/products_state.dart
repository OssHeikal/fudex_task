part of 'products_cubit.dart';

class ProductsState extends Equatable {
  const ProductsState({
    this.status = CubitStatus.init,
    this.deleteStatus = CubitStatus.init,
    this.products = const [],
    this.message = '',
  });

  final CubitStatus status, deleteStatus;
  final List<ProductModel> products;
  final String message;

  ProductsState copyWith({
    CubitStatus? status,
    CubitStatus? deleteStatus,
    List<ProductModel>? products,
    String? message,
  }) {
    return ProductsState(
      status: status ?? this.status,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      products: products ?? this.products,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, deleteStatus, products, message];
}
