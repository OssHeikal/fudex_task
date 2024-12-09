import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// `sl` is the service locator used throughout the app.
///
/// run this command to generate the injection file:
/// - `dart run build_runner build`
///
/// NOTE: Run this command after adding new dependency to the app.
final GetIt sl = GetIt.instance;

// configureInjection is the function that will be called from main.dart
@InjectableInit(initializerName: r'$initGetIt', preferRelativeImports: true, asExtension: false)
Future<GetIt> configureInjection() async => $initGetIt(sl);
