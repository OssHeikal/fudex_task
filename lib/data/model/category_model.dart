import 'package:equatable/equatable.dart';

List<CategoryModel> categoryModelFromJson(dynamic json) {
  return (json['data'] as List).map((e) => CategoryModel.fromJson(e)).toList();
}

// get sub categories from json by id
List<CategoryModel> subCategoryModelFromJson(dynamic json, int id) {
  return (json['data'] as List)
      .map((e) => CategoryModel.fromJson(e))
      .where((element) => element.mainCategoryId == id)
      .toList();
}

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
