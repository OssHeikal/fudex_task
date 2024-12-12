part of 'add_ons_cubit.dart';

class AddOnsState extends Equatable {
  const AddOnsState({
    this.status = CubitStatus.init,
    this.addons = const [],
    this.message = '',
  });

  final CubitStatus status;
  final List<AddonModel> addons;
  final String message;

  List<String> getAddonOptions(String name) {
    return addons.where((element) => element.name == name).map((e) => e.options).expand((element) => element).toList();
  }

  AddOnsState copyWith({
    CubitStatus? status,
    List<AddonModel>? addons,
    String? message,
  }) {
    return AddOnsState(
      status: status ?? this.status,
      addons: addons ?? this.addons,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, addons, message];
}
