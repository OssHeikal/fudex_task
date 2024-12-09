// Widget Extensions

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../main.dart';
import '../resources/resources.dart';
import '../theme/light_theme.dart';
import 'all_extensions.dart';

Duration transitionDuration = const Duration(milliseconds: 300);

extension WidgetExtension on Widget {
  /// set container to view
  Widget setContainerToView({
    double? height,
    double? width,
    double? margin,
    double? padding,
    double? radius,
    Color? color,
    Color? borderColor,
    AlignmentGeometry? alignment,
    List<BoxShadow>? shadows,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      margin: EdgeInsets.all(margin ?? 0),
      padding: EdgeInsets.all(padding ?? 0.r),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          side: borderColor != null ? BorderSide(color: borderColor, width: 1) : BorderSide.none,
        ),
        shadows: shadows,
      ),
      child: this,
    );
  }

  Widget setMainContainer() {
    final context = rootNavigatorKey.currentContext!;
    return setInkContainerToView(
      padding: 14.sp,
      radius: 8.sp,
      color: context.primaryCardColor,
      borderColor: context.variantBorderColor,
    );
  }

  Widget setInkContainerToView({
    double? height,
    double? width,
    double? margin,
    double? padding,
    double? radius,
    Color? color,
    Color? borderColor,
    AlignmentGeometry? alignment,
    List<BoxShadow>? shadows,
  }) {
    return Ink(
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          side: borderColor != null ? BorderSide(color: borderColor, width: 1) : BorderSide.none,
        ),
        shadows: shadows,
      ),
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        margin: EdgeInsets.all(margin ?? 0),
        padding: EdgeInsets.all(padding ?? 0.r),
        child: this,
      ),
    );
  }

  Widget circle({
    double radius = 24,
    double borderWidth = 0,
    Color? backgroundColor,
    Color? borderColor,
    Widget? child,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundColor: borderColor,
      child: child ?? this,
    );
  }

  ClipRRect withGlassEffect({
    double? height,
    double? width,
    Color? color,
    bool hasBorder = true,
    double radius = 16,
    double padding = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
        child: Container(
          height: height ?? 60.h,
          width: width,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(radius.r),
            border: hasBorder ? Border.all(color: color ?? Colors.white.withOpacity(0.6), width: 1.w) : null,
          ),
          child: this,
        ),
      ),
    );
  }

  Widget setTitle({
    String? title,
    Widget? titleIcon,
    double? fontSize,
    TextStyle? titleStyle,
    double gap = 8,
    double titlePadding = 0,
  }) {
    final context = rootNavigatorKey.currentContext!;
    return title != null
        ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(title, style: titleStyle ?? context.bodyLarge.bold.s12).paddingHorizontal(titlePadding),
              titleIcon ?? const SizedBox.shrink()
            ]),
            gap.h.verticalSpace,
            this
          ])
        : this;
  }

  Widget setSvgToView({
    required String svgPath,
    Color? color,
    double size = 24,
    double gap = 8,
    bool isEnd = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isEnd) this,
        if (isEnd) gap.w.horizontalSpace,
        svgPath.toSvg(color: color, height: size, width: size),
        if (!isEnd) gap.w.horizontalSpace,
        if (!isEnd) expand(),
      ],
    );
  }

  Widget setBullet({Color? bulletColor, double size = 4, double indent = 4}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(radius: size, backgroundColor: bulletColor),
        indent.gap,
        this,
      ],
    );
  }

  /// set visibility
  Widget visible(bool visible, {Widget? fallback}) {
    return visible ? this : (fallback ?? const SizedBox.shrink());
  }

  Widget setBorder({
    double? width,
    Color? color,
    double radius = 0,
    double padding = 0,
  }) {
    final context = rootNavigatorKey.currentContext!;
    return Container(
      padding: padding.edgeInsetsAll.w,
      decoration: BoxDecoration(
        border: Border.all(color: color ?? context.variantBorderColor, width: width ?? 1),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: this,
    );
  }

  Widget setCircleBorder(
    BuildContext context, {
    double? width,
    Color? color,
    double padding = 0,
  }) {
    return Container(
      padding: padding.edgeInsetsAll.w,
      decoration: BoxDecoration(
        border: Border.all(color: color ?? context.inputFieldBorderColor, width: width ?? 1),
        shape: BoxShape.circle,
      ),
      child: this,
    );
  }

  /// add custom corner radius each side
  ClipRRect clipRRectOnly({
    double bottomLeft = 0,
    double bottomRight = 0,
    double topLeft = 0,
    double topRight = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft.toDouble()),
        bottomRight: Radius.circular(bottomRight.toDouble()),
        topLeft: Radius.circular(topLeft.toDouble()),
        topRight: Radius.circular(topRight.toDouble()),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// add corner radius
  ClipRRect clipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  ClipRRect clipRRectTop(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  ClipRRect clipRRectBottom(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  ClipRRect clipRRectStart(double radius) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  ClipRRect clipRRectEnd(double radius) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  ClipRRect clipRRectOnlyWithBorder({
    double bottomLeft = 0,
    double bottomRight = 0,
    double topLeft = 0,
    double topRight = 0,
    Color? borderColor,
    double borderWidth = 1,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft.toDouble()),
        bottomRight: Radius.circular(bottomRight.toDouble()),
        topLeft: Radius.circular(topLeft.toDouble()),
        topRight: Radius.circular(topRight.toDouble()),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent, width: borderWidth),
        ),
        child: this,
      ),
    );
  }

  /// set parent widget in center
  Widget center({double? heightFactor, double? widthFactor, bool enabled = true}) {
    return enabled ? Center(heightFactor: heightFactor, widthFactor: widthFactor, child: this) : this;
  }

  /// add tap to parent widget
  Widget onTap(
    void Function()? function, {
    Color? splashColor,
    Color? hoverColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
  }) {
    return InkWell(
      onTap: function,
      splashColor: splashColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      borderRadius: borderRadius,
      // overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: this,
    );
  }

  /// Wrap with ShaderMask widget
  Widget withShaderMask(List<Color> colors, {BlendMode blendMode = BlendMode.srcATop}) {
    return withShaderMaskGradient(LinearGradient(colors: colors), blendMode: blendMode);
  }

  /// Wrap with ShaderMask widget Gradient
  Widget withShaderMaskGradient(Gradient gradient, {BlendMode blendMode = BlendMode.srcATop}) {
    return ShaderMask(shaderCallback: (rect) => gradient.createShader(rect), blendMode: blendMode, child: this);
  }

  /// Validate given widget is not null and returns given value if null.
  Widget validate({Widget value = const SizedBox()}) => this;

  Widget buildWhen(bool value) => value ? this : const SizedBox.shrink();

  Widget withTooltip({required String msg}) => Tooltip(message: msg, child: this);

  Widget withSafeArea({EdgeInsets? minimum}) => SafeArea(minimum: minimum ?? EdgeInsets.zero, child: this);

  Widget bottomSafeArea({EdgeInsets? minimum}) => SafeArea(
        minimum: EdgeInsets.only(left: AppSize.screenPadding, right: AppSize.screenPadding, bottom: 16),
        child: this,
      );

  /// Make your any widget refreshable with RefreshIndicator on top
  // Widget get makeRefreshable => Stack(children: [ListView(), this]);
  RefreshIndicator makeRefreshable(Future<void> Function() onRefresh, {EdgeInsetsGeometry? padding}) {
    return RefreshIndicator.adaptive(
      backgroundColor: LightThemeColors.scaffoldBackground,
      color: LightThemeColors.primary,
      onRefresh: () {
        HapticFeedback.lightImpact();
        return onRefresh();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: padding ?? const EdgeInsets.only(bottom: AppSize.bottomNavBarHeight),
        children: [this],
      ),
    );
  }

  Widget withShimmer({
    Duration duration = const Duration(seconds: 1),
    Color baseColor = Colors.grey,
    Color highlightColor = Colors.grey,
    bool buildWhen = true,
  }) {
    if (!buildWhen) return this;
    if (this is SizedBox) {
      return SizedBox(
        width: (this as SizedBox).width,
        height: (this as SizedBox).height,
        child: Shimmer.fromColors(
          period: duration,
          baseColor: baseColor.withOpacity(0.1),
          highlightColor: highlightColor.withOpacity(0.25),
          child: this,
        ),
      );
    } else if (this is CircleAvatar) {
      return CircleAvatar(
        radius: (this as CircleAvatar).radius,
        backgroundColor: Colors.transparent,
        child: Shimmer.fromColors(
          period: duration,
          baseColor: baseColor.withOpacity(0.1),
          highlightColor: highlightColor.withOpacity(0.25),
          child: this,
        ),
      );
    } else {
      return Shimmer.fromColors(
        period: duration,
        baseColor: baseColor.withOpacity(0.1),
        highlightColor: highlightColor.withOpacity(0.25),
        child: this,
      );
    }
  }
}

extension PaddingExtension on Widget {
  /// return padding top
  Padding paddingTop(double top) {
    return Padding(padding: EdgeInsets.only(top: top), child: this);
  }

  /// return padding left
  Padding paddingLeft(double left) {
    return Padding(padding: EdgeInsets.only(left: left), child: this);
  }

  /// return padding Directional
  Padding paddingStart(double start) {
    return Padding(padding: EdgeInsetsDirectional.only(start: start), child: this);
  }

  Padding paddingEnd(double end) {
    return Padding(padding: EdgeInsetsDirectional.only(end: end), child: this);
  }

  /// return padding right
  Padding paddingRight(double right) {
    return Padding(padding: EdgeInsets.only(right: right), child: this);
  }

  /// return padding bottom
  Padding paddingBottom(double bottom) {
    return Padding(padding: EdgeInsets.only(bottom: bottom), child: this);
  }

  /// return padding all
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// return padding Symmetric
  Padding paddingSymmetric(double horizontal, double vertical) {
    return Padding(padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal), child: this);
  }

  Padding paddingVertical(double padding) {
    return Padding(padding: EdgeInsets.symmetric(vertical: padding), child: this);
  }

  Padding paddingHorizontal(double padding) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: this);
  }

  /// return custom padding from each side
  Padding paddingOnly({double top = 0.0, double left = 0.0, double bottom = 0.0, double right = 0.0}) {
    return Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);
  }

  Padding paddingDirectionalOnly({double top = 0.0, double start = 0.0, double bottom = 0.0, double end = 0.0}) {
    return Padding(padding: EdgeInsetsDirectional.only(top: top, bottom: bottom, start: start, end: end), child: this);
  }

  Padding paddingDirectionalAll({double padding = 0}) {
    return Padding(padding: EdgeInsetsDirectional.all(padding), child: this);
  }
}

/// Extension on the [Widget] class to provide additional layout-related functionality.
extension LayoutExtensions on Widget {
  /// With custom width
  SizedBox withWidth(double width) => SizedBox(width: width, child: this);

  /// With custom height
  SizedBox withHeight(double height) => SizedBox(height: height, child: this);

  /// With custom height and width
  SizedBox withSize(double width, double height) => SizedBox(width: width, height: height, child: this);

  ///scrollable
  Widget scrollable({
    EdgeInsets? padding,
    bool primary = true,
    bool reverse = false,
    ScrollPhysics? physics,
  }) {
    return SingleChildScrollView(
      primary: primary,
      padding: padding ?? EdgeInsets.symmetric(horizontal: AppSize.screenPadding, vertical: 16.h),
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      reverse: reverse,
      child: this,
    );
  }

  Widget withListView({
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool primary = true,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
  }) {
    return ListView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      primary: primary,
      shrinkWrap: shrinkWrap,
      padding: padding ?? EdgeInsets.symmetric(horizontal: AppSize.screenPadding, vertical: 16.h),
      physics: physics,
      children: [this],
    );
  }

  /// add Expanded to parent widget
  Widget expand({flex = 1}) => Expanded(flex: flex, child: this);

  /// add Flexible to parent widget
  Widget flexible({flex = 1, FlexFit? fit, bool buildWhen = true}) {
    return buildWhen ? Flexible(flex: flex, fit: fit ?? FlexFit.loose, child: this) : this;
  }

  /// add FittedBox to parent widget
  Widget fit({BoxFit? fit, AlignmentGeometry? alignment}) {
    return FittedBox(fit: fit ?? BoxFit.contain, alignment: alignment ?? Alignment.center, child: this);
  }

  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);

  Directionality withDirectionality(TextDirection textDirection) {
    return Directionality(textDirection: textDirection, child: this);
  }
}

extension TransformExtension on Widget {
  /// add rotation to parent widget
  Widget rotate({required double angle, bool transformHitTests = true, Offset? origin}) {
    return Transform.rotate(origin: origin, angle: angle.toRadians, transformHitTests: transformHitTests, child: this);
  }

  Widget flipHorizontal({bool enable = true, bool transformHitTests = true}) {
    return Transform.flip(flipX: enable, transformHitTests: transformHitTests, child: this);
  }

  Widget flipVertical({bool enable = true, bool transformHitTests = true}) {
    return Transform.flip(flipY: enable, transformHitTests: transformHitTests, child: this);
  }

  //rotate with animation to parent widget
  Widget rotateWithAnimation({required double angle}) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(angle / 360),
      filterQuality: FilterQuality.high,
      child: this,
    );
  }

  /// add scaling to parent widget
  Widget scale({required double scale, Offset? origin, AlignmentGeometry? alignment, bool transformHitTests = true}) {
    return Transform.scale(
      scale: scale,
      origin: origin,
      alignment: alignment,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// add translate to parent widget
  Widget translate({required Offset offset, bool transformHitTests = true, Key? key}) {
    return Transform.translate(offset: offset, transformHitTests: transformHitTests, key: key, child: this);
  }
}

extension AnimationExtension on Widget {
  Widget setHero(String heroKey) => Hero(tag: heroKey, child: Material(color: Colors.transparent, child: this));

  /// add opacity to parent widget
  Widget opacity({required double opacity, int durationInSecond = 1, Duration? duration}) {
    return AnimatedOpacity(opacity: opacity, duration: duration ?? const Duration(milliseconds: 500), child: this);
  }

  /// Validate given widget is not null and returns given value if null.
  Widget animationSwitch({
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return AnimatedSwitcher(
      duration: duration ?? transitionDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: this,
    );
  }

  Widget setAnimatedContainer({Duration? duration, double? width, double? hight}) {
    return AnimatedContainer(
      width: width,
      height: hight,
      curve: Curves.fastOutSlowIn,
      duration: duration ?? const Duration(seconds: 5),
      child: this,
    );
  }
}

extension TextEx on Text {
  /// add tap to text widget
  Widget clickable({
    required void Function() onTap,
    Color splashColor = Colors.transparent,
    Color highlightColor = Colors.transparent,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double paddingValue = 0.0,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    TextStyle? style,
  }) {
    final ValueNotifier<bool> highlighted = ValueNotifier<bool>(false);
    return ValueListenableBuilder(
      valueListenable: highlighted,
      builder: (context, value, child) {
        return InkWell(
          onTap: onTap,
          splashColor: value ? splashColor.withOpacity(0.5) : splashColor,
          highlightColor: value ? highlightColor.withOpacity(0.5) : highlightColor,
          borderRadius: borderRadius,
          onTapDown: (details) => highlighted.value = true,
          onTapUp: (details) => highlighted.value = false,
          onTapCancel: () => highlighted.value = false,
          child: AnimatedDefaultTextStyle(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 100),
            style: style?.copyWith(color: value ? style.color?.withOpacity(0.5) : style.color) ??
                context.displayLarge.copyWith(
                  fontSize: fontSize.sp,
                  fontWeight: fontWeight,
                  color: value ? context.primaryColor.withOpacity(0.5) : context.primaryColor,
                ),
            child: Padding(
              padding: padding ?? EdgeInsets.all(paddingValue),
              child: this,
            ),
          ),
        );
      },
    );
  }
}

extension ColorEx on Color {
  ColorFilter get colorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}

extension BoolExt on bool {
  T? toggle<T>(T? ifTrue, T? ifFalse) => this ? ifTrue : ifFalse;

  void toggleAction(void Function() ifTrue, void Function() ifFalse) {
    if (this) {
      ifTrue();
    } else {
      ifFalse();
    }
  }
}
