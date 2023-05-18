import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  String phoneCode = "";

  bool isObsecure = true;
  viewPassword() {
    isObsecure = !isObsecure;
    update();
  }

  bool isObsecureCPassword = true;
  viewCPassword() {
    isObsecure = !isObsecure;
    update();
  }
}
