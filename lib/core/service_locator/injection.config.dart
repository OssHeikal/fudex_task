// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasource/datasource.dart' as _i511;
import '../../data/repository/repositories.dart' as _i280;
import '../../presentation/controller/add_ons/add_ons_cubit.dart' as _i505;
import '../../presentation/controller/categories/categories_cubit.dart'
    as _i398;
import '../../presentation/controller/product_details/product_details_cubit.dart'
    as _i196;
import '../../presentation/controller/products/products_cubit.dart' as _i1025;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i196.ProductDetailsCubit>(() => _i196.ProductDetailsCubit());
  gh.lazySingleton<_i511.Datasource>(() => _i511.DatasourceImpl());
  gh.lazySingleton<_i280.Repository>(
      () => _i280.RepositoryImpl(gh<_i511.Datasource>()));
  gh.factory<_i1025.ProductsCubit>(
      () => _i1025.ProductsCubit(gh<_i280.Repository>()));
  gh.factory<_i505.AddOnsCubit>(
      () => _i505.AddOnsCubit(gh<_i280.Repository>()));
  gh.factory<_i398.CategoriesCubit>(
      () => _i398.CategoriesCubit(gh<_i280.Repository>()));
  return getIt;
}
