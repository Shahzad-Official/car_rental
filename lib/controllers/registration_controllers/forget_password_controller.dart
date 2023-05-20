import 'package:car_rental/services/registration_services.dart';
import 'package:car_rental/utils/app_snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../views/registration_screens/login.dart';
import '../../views/registration_screens/reset_password.dart';
import '../../widgets/app_button.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController password = TextEditingController();
  final RegistrationServices _services = RegistrationServices();
  bool isObsecure = true;
  viewPassword() {
    isObsecure = !isObsecure;
    update();
  }

  resetPassword() async {
    isLoading = true;
    update();
    await _services.resetPassword(email: email.text, password: password.text);
    isLoading = false;
    update();
  }

  String countryCode = "";
  String get completeNumber => countryCode + phone.text;
  bool isLoading = false;
  sendOtp() async {
    if (phone.text.isEmpty) {
      AppSnackbar.snackbar(
        title: "Error",
        message: "Please enter phone number!",
      );
    } else if (!email.text.isEmail) {
      AppSnackbar.snackbar(title: "Error", message: "Enter valid email!");
    } else {
      await Connectivity().checkConnectivity().then(
        (value) async {
          if (value == ConnectivityResult.none) {
            AppSnackbar.snackbar(
              title: "Error",
              message: "Check your internet connection!",
            );
          } else {
            isLoading = true;
            update();
            await _services.sendOtp(
              email: email.text,
              number: phone.text,
              phone: completeNumber,
              phoneCode: countryCode,
              isSignUp: false,
            );
            isLoading = false;
            update();
          }
        },
      );
    }
  }

  bool isVerificationLoading = false;
  bool verified = false;
  verifyOtp(bool isSignUp) async {
    if (pin.text.length < 4) {
      AppSnackbar.snackbar(title: "Error", message: "Please enter OTP!");
    } else {
      await Connectivity().checkConnectivity().then(
        (value) async {
          if (value == ConnectivityResult.none) {
            AppSnackbar.snackbar(
              title: "Error",
              message: "Check your internet connection!",
            );
          } else {
            isVerificationLoading = true;
            update();

            await _services.verifyOtp(
              completeNumber,
              pin.text,
              email: email.text,
            );

            verified = _services.otpIsVerified;
            update();
            isVerificationLoading = false;
            update();
            if (verified) {
              if (isSignUp) {
                Get.defaultDialog(
                  title: "",
                  content: LottieBuilder.asset(
                    "assets/animations/verified.json",
                    repeat: false,
                    onLoaded: (p0) {
                      Future.delayed(p0.duration, () {
                        Get.offAll(
                          () => const Login(),
                        );
                      });
                    },
                  ),
                );
              } else {
                Get.to(
                  () => const ResetPassword(),
                );
              }
            } else {
              Get.defaultDialog(
                actions: [
                  AppButton(
                    onTap: () {
                      Get.back();
                    },
                    text: "Back",
                  ),
                ],
                title: "check your entered OTP",
                content: LottieBuilder.asset(
                  "assets/animations/error.json",
                  repeat: false,
                  onLoaded: (p0) {
                    Future.delayed(p0.duration, () {});
                  },
                ),
              );
            }
          }
        },
      );
    }
  }
}
