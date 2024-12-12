part of 'product_details_cubit.dart';

class ProductDetailsState extends Equatable {
  const ProductDetailsState({
    this.status = CubitStatus.init,
    this.message = '',
    this.product = const ProductModel.empty(),
  });

  final CubitStatus status;
  final String message;
  final ProductModel product;

  ProductDetailsState copyWith({
    CubitStatus? status,
    String? message,
    ProductModel? product,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      message: message ?? this.message,
      product: product ?? this.product,
    );
  }

  @override
  List<Object> get props => [status, message, product];
}
