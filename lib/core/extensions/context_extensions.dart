import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/overlay_utils.dart';

double tabletBreakpointGlobal = 600.0;
double desktopBreakpointGlobal = 720.0;

// Context Extensions
extension ContextExtensions on BuildContext {
  /// return screen size
  Size get size => MediaQuery.of(this).size;

  /// return screen width
  double get width => MediaQuery.of(this).size.width;

  /// return screen height
  double get height => MediaQuery.of(this).size.height;

  /// return screen devicePixelRatio
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// is arabic
  bool get isArabic => Directionality.of(this) == TextDirection.rtl;

  /// returns brightness
  Brightness platformBrightness() => MediaQuery.of(this).platformBrightness;

  /// Return the height of status bar
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Return the height of navigation bar
  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;

  /// Returns DefaultTextStyle.of(context)
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  /// Returns Form.of(context)
  FormState? get formState => Form.of(this);

  /// Returns Scaffold.of(context)
  ScaffoldState get scaffoldState => Scaffold.of(this);

  /// Returns Overlay.of(context)
  OverlayState? get overlayState => Overlay.of(this);

  /// Request focus to given FocusNode
  void requestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  /// Request focus to given FocusNode
  void unFocus(FocusNode focus) => focus.unfocus();

  bool isPhone() => MediaQuery.of(this).size.width < tabletBreakpointGlobal;

  bool isTablet() =>
      MediaQuery.of(this).size.width < desktopBreakpointGlobal &&
      MediaQuery.of(this).size.width >= tabletBreakpointGlobal;

  bool isDesktop() => MediaQuery.of(this).size.width >= desktopBreakpointGlobal;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  TargetPlatform get platform => Theme.of(this).platform;

  bool get isAndroid => platform == TargetPlatform.android;

  bool get isIOS => platform == TargetPlatform.iOS;

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  double get keyboardPadding => MediaQuery.of(this).viewInsets.bottom;

  void hideKeyboard() => FocusScope.of(this).unfocus();

  void showKeyboard() => FocusScope.of(this).requestFocus(FocusNode());

  void showDialog(Widget dialog) => OverlayUtils.showCustomDialog(context: this, child: dialog);

  Future<T?> showBottomSheet<T>(Widget bottomSheet) =>
      OverlayUtils.showBottomSheet<T>(context: this, child: bottomSheet);

  Future<T?> showScrollableBottomSheet<T>(Widget content, {Widget? bottom}) =>
      OverlayUtils.showScrollableBottomSheet<T>(context: this, child: content, bottom: bottom);

  // pop
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  // push
  Future<T?> push<T>(Widget page) => Navigator.of(this).push<T>(CupertinoPageRoute(builder: (_) => page));
}
