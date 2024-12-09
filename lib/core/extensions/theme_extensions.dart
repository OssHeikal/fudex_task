import 'package:flutter/material.dart';

import 'all_extensions.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  // ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  // primary color
  Color get primaryColor => theme.colorScheme.primary;
  // secondary color
  Color get secondaryColor => theme.colorScheme.secondary;

  // surface color
  Color get primaryContainerColor => colorScheme.primaryContainer;
  Color get secondaryContainerColor => colorScheme.secondaryContainer;
  Color get tertiaryContainerColor => colorScheme.tertiaryContainer;

  Color get primaryCardColor => theme.cardColor;
  Color get secondaryCardColor => theme.cardTheme.color!;

  // background color
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;
  Color get bottomSheetBackground => theme.bottomSheetTheme.backgroundColor!;

  // validation colors
  Color get errorColor => theme.colorScheme.error;
  Color get successColor => headlineSmall.color!;
  Color get warningColor => headlineLarge.color!;

  Color get errorContainerColor => theme.colorScheme.errorContainer;

  Color get disabledButtonColor => labelLarge.color!;

  // input decoration
  TextStyle get hintTextStyle => theme.inputDecorationTheme.hintStyle!;
  Color get fillColor => theme.inputDecorationTheme.fillColor!;
  Color get inputFieldBorderColor => theme.inputDecorationTheme.border!.borderSide.color;
  Color get hintColor => theme.inputDecorationTheme.hintStyle!.color!;
  Color get inputFieldIconsColor => bodySmall.color!;

  Color get primaryBorder => bodyMedium.color!;
  Color get variantBorderColor => labelSmall.color!;
  Color get secondaryBorderColor => labelLarge.color!;

  // icons
  IconThemeData? get iconTheme => theme.appBarTheme.iconTheme;
  Color get iconColor => theme.iconTheme.color!;
  Color get iconColorDisabled => labelLarge.color!;
  // Color get iconColorActive => theme.bottomNavigationBarTheme.selectedItemColor!;
  Color get iconColorInactive => labelMedium.color!;
  Color get iconColorSelected => theme.bottomNavigationBarTheme.selectedItemColor!;
  Color get iconColorUnselected => theme.bottomNavigationBarTheme.unselectedItemColor!;

  // TextTheme
  TextTheme get textTheme => theme.textTheme;
  TextStyle get displayLarge => textTheme.displayLarge!;
  TextStyle get displayMedium => textTheme.displayMedium!;
  TextStyle get displaySmall => textTheme.displaySmall!;
  TextStyle get headlineLarge => textTheme.headlineLarge!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;
  TextStyle get errorStyle => textTheme.headlineMedium!.s12.regular;
}
