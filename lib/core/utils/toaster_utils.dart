import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_toast.dart';


class Toaster {
  Toaster._();
  static void showToast(String text, {bool isError = true}) {
    BotToast.showCustomText(
      duration: const Duration(seconds: 3),
      toastBuilder: (cancelFunc) => CustomToast(isError: isError, text: text),
    );
  }

  static void showLoading() {
    BotToast.showCustomLoading(toastBuilder: (cancelFunc) {
      return const Card(
        color: Colors.white,
        child: Padding(padding: EdgeInsets.all(20.0), child: CircularProgressIndicator()),
      );
    });
  }

  static void closeLoading() {
    BotToast.closeAllLoading();
  }

  static void showNotification({
    Widget Function(void Function())? leading,
    Widget Function(void Function())? title,
    Widget Function(void Function())? subtitle,
    Color? backgroundColor,
  }) {
    BotToast.showNotification(
      title: title,
      subtitle: subtitle,
      leading: leading,
      backgroundColor: backgroundColor,
    );
  }
}
