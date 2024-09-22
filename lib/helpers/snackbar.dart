import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Snackbar will display message on the screen like a toast/notification
class SnackbarHelper {

  //Snackbar main skeleton
  static void _showSnackbar({
    required String title,
    required String description,
    required Icon icon,
    required Color backgroundColor,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      title,
      description,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: snackPosition,
      titleText: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        description,
        style: const TextStyle(color: Colors.white),
      ),
      margin: const EdgeInsets.all(10),
      icon: icon,
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
    );
  }

  //Snackbar for error
  static void showError({String title = '', String description = ''}) {
    _showSnackbar(
      title: title,
      description: description,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      backgroundColor: Colors.redAccent.withOpacity(0.5),
    );
  }

  //Snackbar for warning
  static void showWarning({String title = '', String description = ''}) {
    _showSnackbar(
      title: title,
      description: description,
      icon: const Icon(Icons.warning_amber_outlined, color: Colors.white),
      backgroundColor: Colors.black.withOpacity(0.5),
      snackPosition: SnackPosition.TOP,
    );
  }

  //Snackbar for success
  static void showSuccess({String title = '', String description = ''}) {
    _showSnackbar(
      title: title,
      description: description,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      backgroundColor: Colors.green.withOpacity(0.7),
    );
  }
}
