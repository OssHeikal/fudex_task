part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.mainCategories = const [],
    this.subCategories = const [],
    this.status = CubitStatus.init,
    this.message = '',
  });

  final List<CategoryModel> mainCategories;
  final List<CategoryModel> subCategories;
  final CubitStatus status;
  final String message;

  CategoriesState copyWith({
    List<CategoryModel>? mainCategories,
    List<CategoryModel>? subCategories,
    CubitStatus? status,
    String? message,
  }) {
    return CategoriesState(
      mainCategories: mainCategories ?? this.mainCategories,
      subCategories: subCategories ?? this.subCategories,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [mainCategories, subCategories, status, message];
}
