import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../navigator_keys.dart';

class ToastHelper {
  static void showErrorToast({
    String? title,
    String? message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      toastification.show(
        context: context,
        icon: const Icon(Icons.cancel_outlined, color: Colors.white),
        type: ToastificationType.error,
        title: title != null ? Text(title) : null,
        description: message != null ? Text(message) : null,
        autoCloseDuration: duration,
      );
    } else {
      debugPrint("context null");
    }
  }

  static void showSuccessToast({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final context = navigatorKey.currentContext;

    if (context != null) {
      toastification.show(
        context: context,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        type: ToastificationType.success,
        title: Text(message),
        autoCloseDuration: duration,
      );
    } else {
      debugPrint("context null");
    }
  }

  static void showCoolErrorToast({required String title,  required String message}) {
    try {
      ElegantNotification.error(
        width: 380,
        title:  Text(
          title,
          style: AppStyles.title3Medium,
        ),
        description: Text(
          message,
          style: AppStyles.title3Regular,
        ),
        icon: const Icon(
          Icons.error_outline,
          color: AppColors.red,
          size: 45,
        ),
        
        animationCurve: Curves.easeInOut,
        toastDuration: const Duration(seconds: 6),
        animation: AnimationType.fromLeft,
        position: Alignment.bottomLeft,
        border: Border.all(color: AppColors.grey.shade200),
      ).show(navigatorKey.currentContext!);
    } catch (e) {
      debugPrint("failed show : ${e.toString()}");
    }
  }
}
