import 'package:car_rental/services/registration_services.dart';
import 'package:car_rental/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RegistrationServices _services = RegistrationServices();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObsecure = true;
  viewPassword() {
    isObsecure = !isObsecure;
    update();
  }

  bool isLoading = false;
  validateUser() async {
    if (email.text.isEmpty || !email.text.isEmail) {
      AppSnackbar.snackbar(title: "Error", message: "Enter valid email!");
    } else {
      isLoading = true;
      update();
      await _services.login(
        email: email.text,
        password: password.text,
      );
      isLoading = false;
      update();
    }
  }
}
