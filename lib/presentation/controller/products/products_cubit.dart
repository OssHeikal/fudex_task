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
  ProductsCubit(this._repository) : super(ProductsState());
}
