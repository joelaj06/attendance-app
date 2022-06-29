import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ExceptionIndicator {
  void showSuccess({
    required String title,
    required String message,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  void showError({
    required String title,
    required String message,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(
          Icons.cancel_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }

  void showInfo({
    required String title,
    required String message,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        colorText: Colors.white);
  }
}
