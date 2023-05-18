import 'package:car_rental/utils/app_snackbar.dart';
import 'package:car_rental/views/registration_screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObsecure = true;
  viewPassword() {
    isObsecure = !isObsecure;
    update();
  }

  resetPassword() {}

  String countryCode = "";
  String get completeNumber => countryCode + phone.text;
  sendOtp() async {
    if (phone.text.isEmpty) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please enter phone number!");
    } else {
      Get.to(
        () => OtpScreen(),
      );
    }
  }
}
