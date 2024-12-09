import 'package:flutter/material.dart';

import '../theme/light_theme.dart';

class TextStylesManager {
  const TextStylesManager._();
  static TextStyle font = const TextStyle();
}

class ShadowStyles {
  const ShadowStyles._();
  static List<BoxShadow> bottomSheetShadow = [
    BoxShadow(
      color: LightThemeColors.shadowBottomSheet,
      blurRadius: 32,
      offset: const Offset(4, 10),
      spreadRadius: 0,
    )
  ];

  static List<BoxShadow> cardShadow = [
    const BoxShadow(
      color: Color(0x23000000),
      blurRadius: 8,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];

  static List<BoxShadow> tabBarShadow = [
    BoxShadow(
      blurStyle: BlurStyle.inner,
      color: Colors.black.withOpacity(0.12),
      blurRadius: 10,
      offset: const Offset(-1, -1),
      spreadRadius: 0,
    ),
    BoxShadow(
      blurStyle: BlurStyle.inner,
      color: Colors.black.withOpacity(0.12),
      blurRadius: 10,
      offset: const Offset(1, 1),
      spreadRadius: 0,
    )
  ];

  static List<BoxShadow> tileShadow = [
    const BoxShadow(
      color: Color(0x1E000000),
      blurRadius: 10,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];
}

class GradientStyles {
  const GradientStyles._();
}
