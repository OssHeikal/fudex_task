import 'package:flutter/material.dart';

import '../../extensions/all_extensions.dart';
import '../../widgets/custom_loading.dart';

enum CubitStatus {
  loading,
  success,
  failed,
  init;

  Widget build({
    Widget? onInit,
    Widget? onLoading,
    Widget? onFailed,
    required Widget onSuccess,
    bool enableLoading = true,
  }) {
    switch (this) {
      case CubitStatus.init:
        return onInit ?? const SizedBox.shrink();
      case CubitStatus.loading:
        return enableLoading ? onLoading ?? const CustomLoading() : onSuccess;
      case CubitStatus.success:
        return onSuccess;
      case CubitStatus.failed:
        return onFailed ?? const Text('Failed').center();
    }
  }

  void listen({
    void Function()? onLoading,
    void Function()? onSuccess,
    void Function()? onFailed,
    void Function()? onInit,
  }) {
    switch (this) {
      case CubitStatus.init:
        onInit?.call();
        break;
      case CubitStatus.loading:
        onLoading?.call();
        break;
      case CubitStatus.success:
        onSuccess?.call();
        break;
      case CubitStatus.failed:
        onFailed?.call();
        break;
    }
  }

  bool get isFailed => this == CubitStatus.failed;

  bool get isLoading => this == CubitStatus.loading;

  bool get isInit => this == CubitStatus.init;

  bool get isSuccess => this == CubitStatus.success;
}
