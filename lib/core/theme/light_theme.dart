import 'package:flutter/material.dart';

import '../extensions/all_extensions.dart';
import '../resources/resources.dart';
import 'theme_manager.dart';

// Define your light theme colors
class LightThemeColors {
  const LightThemeColors._();
  // Primary Colors
  static const Color primary = Color(0xFFDB1D4A);

  // grey shades
  static const int _greyValue = 0xFF303030;
  static MaterialColor greyShade = const MaterialColor(
    _greyValue,
    <int, Color>{
      100: Color(0xFFD9D9D9),
      200: Color(0xFFBFBFBF),
      300: Color(0xFF808080),
      400: Color(0xFF666666),
      500: Color(_greyValue),
      600: Color(0xFF000000),
    },
  );

  // On Primary
  static const Color onPrimary = Colors.white;

  static const int _onPrimaryValue = 0xFFFFFFFF;
  static MaterialColor onPrimaryShade = const MaterialColor(
    _onPrimaryValue,
    <int, Color>{
      100: Color(_onPrimaryValue),
      200: Color(0xFFFFFDFA),
      300: Color(0xFFFBF9F4),
      400: Color(0xFFF8F8F8),
      500: Color(0xFFF0F0F0)
    },
  );

  // Validation Colors:
  static const Color error = Color(0xFFFF0000);
  static const Color warning = Color(0xFFE7D215);
  static const Color success = Color(0xFF1A7520);

  static const Color errorContainer = Color(0xFFFFE0E0);
  static const Color warningContainer = Color(0xFFFFF7D6);
  static const Color successContainer = Color(0xFFEDF7EE);

  // Background Color
  static const Color background = Colors.white;
  static const Color scaffoldBackground = Colors.white;
  static const Color bottomSheetBackground = Colors.white;
  static const Color dialogBackground = Colors.white;

  // Surface Colors
  static Color primaryContainer = greyShade[100]!;
  static Color secondaryContainer = onPrimaryShade[500]!;
  static Color disabledContainer = greyShade[200]!;
  static Color disabledButton = greyShade[200]!;
  // validation Surface Colors

  // Text Colors
  static const Color tertiaryText = Color(0xFF2D2D2D);
  static Color hintText = greyShade[300]!;
  static Color unActive = greyShade[400]!;
  static Color tabBarText = greyShade[500]!;

  // Icons Colors
  static Color primaryIcon = greyShade[300]!;
  static Color unselectedIcon = greyShade[300]!;
  static Color selectedIcon = primary;
  static Color onBackgroundIcon = greyShade[600]!;
  static Color prefixIcon = greyShade[300]!;

  // border Colors
  static Color dividerColor = greyShade[100]!;
  static Color border = greyShade[100]!;
  static Color disabledBorder = greyShade[400]!;
  static Color inputFieldBorder = greyShade[200]!;

  // shadow
  static Color shadowBottomSheet = Colors.black.withOpacity(0.1);
  static Color shadow = Colors.black.withOpacity(0.08);

  // mask color
  static Color maskColor = Colors.black.withOpacity(0.48);

  // gradient
  static const List<Color> primaryGradientColors = [
    Color(0xFFA47A1E),
    Color(0xFFD3A84C),
    Color(0xFFFFEC94),
    Color(0xFFE6BE69),
    Color(0xFFFFD87C),
    Color(0xFFB58F3E),
    Color(0xFF956D13),
  ];

  static List<Color> maskGradientColors = [Colors.black.withOpacity(0), primary.withOpacity(0.8)];
  static List<Color> maskColors = [Colors.black.withOpacity(0.58), primary.withOpacity(0.58)];
}

class LightTheme {
  static ThemeData getTheme() {
    AppThemeManager.setStatusBarAndNavigationBarColors(ThemeMode.light);
    return ThemeData(
      //* Light Theme
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackground,
      useMaterial3: true,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: FontConstants.fontFamily,
      cardColor: LightThemeColors.onPrimaryShade[400],
      //* Card Theme *//

      //* Color Scheme
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: LightThemeColors.primary,
        onPrimary: LightThemeColors.onPrimary,
        primaryContainer: LightThemeColors.primaryContainer,
        surfaceTint: const Color(0xFFFFFFFF),
        onPrimaryContainer: const Color(0xff001f24),
        secondary: const Color(0xFFDB1D4A),
        onSecondary: const Color(0xFFFFFFFF),
        secondaryContainer: LightThemeColors.secondaryContainer,
        onSecondaryContainer: const Color(0xff251a00),
        tertiary: const Color(0xff49672d),
        onTertiary: const Color(0xffffffff),
        tertiaryContainer: const Color(0xffcaeea6),
        onTertiaryContainer: const Color(0xff0e2000),
        error: LightThemeColors.error,
        onError: const Color(0xffffffff),
        errorContainer: const Color(0xffffdad6),
        onErrorContainer: const Color(0xff3b0908),
        surface: const Color(0xfff5fafb),
        onSurface: const Color(0xff171d1e),
        onSurfaceVariant: const Color(0xff414941),
        outline: const Color(0xff727970),
        outlineVariant: const Color(0xffc1c9be),
        shadow: const Color(0xff000000),
        scrim: const Color(0xff000000),
        inverseSurface: const Color(0xff2b3133),
        inversePrimary: const Color(0xff82d3e0),
        primaryFixed: const Color(0xff9eeffd),
        onPrimaryFixed: const Color(0xff001f24),
        primaryFixedDim: const Color(0xff82d3e0),
        onPrimaryFixedVariant: const Color(0xff004f58),
        secondaryFixed: const Color(0xffffdf9b),
        onSecondaryFixed: const Color(0xff251a00),
        secondaryFixedDim: const Color(0xffe8c26c),
        onSecondaryFixedVariant: const Color(0xff5a4300),
        tertiaryFixed: const Color(0xffcaeea6),
        onTertiaryFixed: const Color(0xff0e2000),
        tertiaryFixedDim: const Color(0xffafd18c),
        onTertiaryFixedVariant: const Color(0xff334e18),
        surfaceDim: const Color(0xffd5dbdc),
        surfaceBright: const Color(0xfff5fafb),
        surfaceContainerLowest: const Color(0xffffffff),
        surfaceContainerLow: const Color(0xffeff5f6),
        surfaceContainer: const Color(0xffe9eff0),
        surfaceContainerHigh: const Color(0xffe3e9ea),
        surfaceContainerHighest: const Color(0xffdee3e5),
      ),

      //* App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: LightThemeColors.background,
        titleTextStyle: TextStylesManager.font.s16.bold.setColor(LightThemeColors.greyShade[600]!),
        iconTheme: IconThemeData(color: LightThemeColors.onBackgroundIcon),
      ),

      //* Text Theme
      textTheme: TextTheme(
        // Display
        displayLarge: TextStylesManager.font.copyWith(),
        displayMedium: TextStylesManager.font.copyWith(),
        displaySmall: TextStylesManager.font.copyWith(),

        // Header
        headlineLarge: TextStylesManager.font.copyWith(color: LightThemeColors.warning),
        headlineMedium: TextStylesManager.font.copyWith(color: LightThemeColors.error),
        headlineSmall: TextStylesManager.font.copyWith(color: LightThemeColors.success),

        // Title
        titleLarge: TextStylesManager.font.copyWith(color: LightThemeColors.primary),
        titleMedium: TextStylesManager.font.copyWith(color: LightThemeColors.onPrimary),
        titleSmall: TextStylesManager.font.copyWith(),

        // Body
        bodyLarge: TextStylesManager.font.copyWith(color: LightThemeColors.greyShade[600]),
        bodyMedium: TextStylesManager.font.copyWith(color: LightThemeColors.greyShade[500]),
        bodySmall: TextStylesManager.font.copyWith(color: LightThemeColors.greyShade[400]),

        // label
        labelLarge: TextStylesManager.font.copyWith(color: LightThemeColors.greyShade[300]),
        labelMedium: TextStylesManager.font.copyWith(color: LightThemeColors.greyShade[200]),
        labelSmall: TextStylesManager.font.copyWith(color: LightThemeColors.greyShade[100]),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: LightThemeColors.onBackgroundIcon),

      splashFactory: InkRipple.splashFactory,

      //*  bottomNavigationBarTheme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStylesManager.font.regular.s10.setColor(LightThemeColors.selectedIcon),
        unselectedLabelStyle: TextStylesManager.font.regular.s10.setColor(LightThemeColors.unselectedIcon),
        backgroundColor: LightThemeColors.background,
        selectedItemColor: LightThemeColors.selectedIcon,
        unselectedItemColor: LightThemeColors.unselectedIcon,
      ),

      //* Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        dragHandleSize: const Size(200, 4),
        dragHandleColor: LightThemeColors.greyShade[200],
        backgroundColor: LightThemeColors.bottomSheetBackground,
        elevation: 0,
      ),

      //* Tab Bar Theme
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: LightThemeColors.primary,
        indicator: BoxDecoration(
          borderRadius: 4.borderRadius,
          color: LightThemeColors.primary,
        ),
        labelPadding: 0.edgeInsetsAll,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: InkRipple.splashFactory,
        dividerColor: Colors.transparent,
        labelColor: LightThemeColors.onPrimary,
        unselectedLabelColor: LightThemeColors.tabBarText,
        labelStyle: TextStylesManager.font.s12.semiBold.setColor(LightThemeColors.onPrimary),
        unselectedLabelStyle: TextStylesManager.font.s12.semiBold.setColor(LightThemeColors.tabBarText),
      ),

      //* ElevatedButtonThemeData
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppThemeManager.elevatedButtonStyleTheme(
          buttonColor: LightThemeColors.primary,
          textColor: LightThemeColors.onPrimary,
        ),
      ),

      //* TextButtonThemeData
      textButtonTheme: const TextButtonThemeData(),

      //* dividerTheme
      dividerTheme: DividerThemeData(thickness: 1, color: LightThemeColors.dividerColor),

      expansionTileTheme: ExpansionTileThemeData(
        iconColor: LightThemeColors.onBackgroundIcon,
        textColor: LightThemeColors.greyShade,
      ),

      //* Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: TextStylesManager.font.regular.s14.ellipsis.setColor(LightThemeColors.hintText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.inputBorderRadius),
          borderSide: BorderSide(color: LightThemeColors.inputFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.inputBorderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.inputBorderRadius),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.inputBorderRadius),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.inputBorderRadius),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: LightThemeColors.primaryContainer,
      ),
    );
  }
}
