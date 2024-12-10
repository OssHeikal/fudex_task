import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/enums/cubit_status_enum.dart';
import '../../../data/model/addon_model.dart';
import '../../../data/repository/repositories.dart';

part 'add_ons_state.dart';

@injectable
class AddOnsCubit extends Cubit<AddOnsState> {
  final Repository _repository;
  AddOnsCubit(this._repository) : super(const AddOnsState());

  void getAddOns() async {
    emit(state.copyWith(status: CubitStatus.loading));
    final response = await _repository.getAddOns();
    response.fold(
      (failure) => emit(state.copyWith(status: CubitStatus.failed, message: failure.message)),
      (data) => emit(state.copyWith(status: CubitStatus.success, addons: data)),
    );
  }
}
