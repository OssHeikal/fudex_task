import 'package:equatable/equatable.dart';

import '../../core/resources/enums/addon_type_enum.dart';

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

  @override
  List<Object?> get props => [name, options, inputType];
}