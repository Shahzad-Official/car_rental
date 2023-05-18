import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppSnackbar {
  static snackbar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: AppText(
        text: title,
        fontSize: 17,
        fontWeight: FontWeight.w900,
      ),
      messageText: AppText(
        text: message,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
