import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../resources/resources.dart';
import '../widgets/custom_button.dart';

class OverlayUtils {
  /// Shows a custom dialog.
  ///
  /// This method is used to display a custom dialog on the screen.
  /// The [child] widget is the content of the dialog.
  static void showCustomDialog({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      barrierDismissible: barrierDismissible,
      builder: (context) => Material(color: Colors.transparent, child: child),
    );
  }

  /// Shows a bottom sheet.
  ///
  /// This method is used to display a bottom sheet on the screen.
  /// The [child] widget is the content of the bottom sheet.
  static Future<T?> showBottomSheet<T>({required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: 16.topBorderRadius),
      backgroundColor: context.bottomSheetBackground,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(0.r)),
              ),
              child: child.setContainerToView(width: context.width),
            ),
          ],
        );
      },
    );
  }

  /// Shows a scrollable bottom sheet.
  ///
  /// This method is used to display a scrollable bottom sheet on the screen.
  /// The [child] widget is the content of the bottom sheet.
  static Future<T?> showScrollableBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    Color? barrierColor,
    Widget? bottom,
  }) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useRootNavigator: true,
      useSafeArea: true,
      barrierColor: barrierColor,
      shape: RoundedRectangleBorder(borderRadius: 16.topBorderRadius),
      backgroundColor: context.bottomSheetBackground,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.85,
          minChildSize: 0.5,
          initialChildSize: 0.85,
          builder: (context, controller) => Column(
            children: [
              ListView(controller: controller, children: [child]).expand(),
              if (bottom != null)
                bottom.withSafeArea(minimum: AppSize.screenPadding.edgeInsetsHorizontal).paddingTop(8),
            ],
          ),
        );
      },
    );
  }

  /// Opens the setting permission dialog.
  ///
  /// This method is used to open a dialog that prompts the user to navigate to the app's settings
  /// in order to grant a specific permission. The dialog provides a convenient way for the user
  /// to grant the required permission without manually navigating through the device settings.
  static openSettingPermissionDialog({
    String? title,
    String? actionTitle,
    required String message,
  }) {
    return showDialog(
        barrierDismissible: false,
        context: rootNavigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: context.scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? 'Permission Required',
                  style: context.bodyLarge.s16.medium,
                ),
                16.gap,
                Text(
                  message,
                  style: context.bodyLarge.s14.regular,
                ),
              ],
            ).setContainerToView(color: context.scaffoldBackgroundColor),
            actions: [
              Material(
                child: CustomButton(
                  label: actionTitle ?? 'Open Settings',
                  onPressed: () async => openAppSettings(),
                ),
              ),
            ],
          );
        });
  }
}
