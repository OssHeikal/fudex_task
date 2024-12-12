import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/enums/cubit_status_enum.dart';
import '../../../data/model/product_model.dart';

part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(const ProductDetailsState());

  void addProduct(ProductModel product) {
    emit(state.copyWith(product: product, status: CubitStatus.success));
  }
}
