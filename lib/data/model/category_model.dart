import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final int? mainCategoryId;

  const CategoryModel({
    required this.id,
    required this.name,
    this.mainCategoryId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      mainCategoryId: json['mainCategoryId'] as int?,
    );
  }

  const CategoryModel.empty()
      : id = 0,
        name = '',
        mainCategoryId = null;

  @override
  List<Object?> get props => [id, name, mainCategoryId];
}
