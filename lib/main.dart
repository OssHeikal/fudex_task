import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc_observer/app_bloc_observer.dart';
import 'core/service_locator/injection.dart';
import 'core/theme/light_theme.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  Future.wait([
    ScreenUtil.ensureScreenSize(),
    configureInjection(),
  ]).then(
    (value) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 852),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Fudex',
          navigatorKey: rootNavigatorKey,
          locale: const Locale('ar', 'EG'),
          builder: BotToastInit(),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: LightTheme.getTheme(),
          home: const Scaffold(),
        );
      },
    );
  }
}
