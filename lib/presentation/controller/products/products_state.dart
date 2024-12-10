part of 'products_cubit.dart';

class ProductsState extends Equatable {
  const ProductsState({
    this.status = CubitStatus.init,
    this.products = const [],
    this.message = '',
  });

  final CubitStatus status;
  final List<ProductModel> products;
  final String message;

  ProductsState copyWith({
    CubitStatus? status,
    List<ProductModel>? products,
    String? message,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, products, message];
}
