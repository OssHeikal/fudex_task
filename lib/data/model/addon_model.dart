import 'package:equatable/equatable.dart';

import '../../core/resources/enums/addon_type_enum.dart';

List<AddonModel> addonModelFromJson(dynamic json) {
  return (json['data'] as List).map((e) => AddonModel.fromJson(e)).toList();
}

class AddonModel extends Equatable {
  final String name;
  final List<String> options;
  final AddonInputType inputType;

  const AddonModel({
    required this.name,
    required this.options,
    required this.inputType,
  });

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      name: json['name'] as String,
      options: List<String>.from(json['options'] as List),
      inputType: AddonInputType.fromString(json['inputType']),
    );
  }

  // copyWith method
  AddonModel copyWith({
    String? name,
    List<String>? options,
    AddonInputType? inputType,
  }) {
    return AddonModel(
      name: name ?? this.name,
      options: options ?? this.options,
      inputType: inputType ?? this.inputType,
    );
  }

  @override
  List<Object?> get props => [name, options, inputType];
}
