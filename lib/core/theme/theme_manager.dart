import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';
import 'light_theme.dart';

class AppThemeManager {
  const AppThemeManager._();

  static ValueNotifier<bool> darkModeEnabled = ValueNotifier(false);
  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  static ButtonStyle elevatedButtonStyleTheme({
    required Color buttonColor,
    required Color textColor,
    Color? buttonColorPressed,
    Color? textColorPressed,
  }) {
    return ButtonStyle(
      textStyle: WidgetStateProperty.all<TextStyle>(TextStylesManager.font.s16.semiBold),
      shape: WidgetStateProperty.all<StadiumBorder>(const StadiumBorder()),
      minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, AppSize.buttonHeight)),
      elevation: WidgetStateProperty.all(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return buttonColorPressed ?? LightThemeColors.primary.withOpacity(.8);
          }
          return buttonColor;
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return textColorPressed ?? textColor;
          }
          return textColor;
        },
      ),
    );
  }
}
