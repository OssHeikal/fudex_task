import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/enums/cubit_status_enum.dart';
import '../../../data/model/category_model.dart';
import '../../../data/repository/repositories.dart';

part 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final Repository _repository;
  CategoriesCubit(this._repository) : super(const CategoriesState()) {
    _getMainCategories();
  }

  void _getMainCategories() async {
    emit(state.copyWith(status: CubitStatus.loading));
    final response = await _repository.getMainCategories();
    response.fold(
      (failure) => emit(state.copyWith(status: CubitStatus.failed, message: failure.message)),
      (data) => emit(state.copyWith(status: CubitStatus.success, mainCategories: data)),
    );
  }

  void getSubCategories(int id) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final response = await _repository.getSubCategories(id);
    response.fold(
      (failure) => emit(state.copyWith(status: CubitStatus.failed, message: failure.message)),
      (data) => emit(state.copyWith(status: CubitStatus.success, subCategories: data)),
    );
  }
}
