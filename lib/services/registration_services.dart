import 'dart:convert';

import 'package:car_rental/constants/api_constants.dart';
import 'package:car_rental/models/user_model.dart';
import 'package:car_rental/utils/app_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

import '../views/home/main_page.dart';
import '../views/registration_screens/login.dart';
import '../views/registration_screens/otp_screen.dart';

class RegistrationServices {
  Box box = Hive.box("Data");

  UserModel userModel = UserModel();
  login({
    required String email,
    required String password,
  }) async {
    await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
      body: {
        "email": email,
        "password": password,
      },
    ).then(
      (value) {
        Map<String, dynamic> data = jsonDecode(value.body);

        if (value.statusCode == 200) {
          userModel = UserModel.fromJson(data);
          box.put("userData", data['data']);

          box.put("loginToken", userModel.token);
          box.put("isLogedin", true);
          AppSnackbar.snackbar(
            title: "Message",
            message: userModel.message.toString(),
          );
          Get.deleteAll();
          Get.offAll(
            () => const MainPage(),
          );
        } else {
          AppSnackbar.snackbar(title: "Error", message: data['message']);
        }
      },
    ).catchError(
      (err) {
        debugPrint(err.toString());
      },
    );
  }

  updateUserStatus({
    required String email,
    required bool isVerified,
  }) async {
    Map<String, dynamic> data = {
      "email": email,
      "isVerified": isVerified,
    };

    await put(
      Uri.parse(
        ApiConstants.baseUrl + ApiConstants.updateStatus,
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    ).then((value) {
      var data = jsonDecode(value.body);
      if (value.statusCode == 200) {
        debugPrint(data.toString());
      } else {
        debugPrint(data.toString());
      }
    });
  }

  sendOtp({
    required String email,
    required String phoneCode,
    required String number,
    required String phone,
    required bool isSignUp,
  }) async {
    await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.sendOtp),
      body: {
        "email": email,
        "phoneCode": phoneCode,
        "number": number,
        "phone": phone,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        AppSnackbar.snackbar(
            title: "Message", message: "OTP has been sent successfully!");
        Get.to(
          () => OtpScreen(
            isSignUp: isSignUp,
          ),
        );
      }
      debugPrint(value.body);
      var data = jsonDecode(value.body);
      AppSnackbar.snackbar(title: "Error", message: data['message']);
    }).catchError(
      (err) {
        debugPrint(err.toString());
      },
    );
  }

  bool otpIsVerified = false;
  verifyOtp(
    String phoneNumber,
    String otp, {
    required String email,
  }) async {
    await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.verifyOtp),
      body: {
        "phone": phoneNumber,
        "otp": otp,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        AppSnackbar.snackbar(
            title: "Message", message: "OTP has been veified successfully!");

        await updateUserStatus(
          email: email,
          isVerified: true,
        );
        otpIsVerified = true;
      }
      debugPrint(value.body);
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }

  resetPassword({
    required String email,
    required String password,
  }) async {
    await put(
      Uri.parse(
        ApiConstants.baseUrl + ApiConstants.resetPassword,
      ),
      body: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      var data = jsonDecode(value.body);
      if (value.statusCode == 200) {
        Get.defaultDialog(
          title: "Passwor has been reset successfully",
          content: LottieBuilder.asset(
            "assets/animations/verified.json",
            repeat: false,
            onLoaded: (p0) {
              Future.delayed(
                p0.duration,
                () {
                  Get.offAll(
                    () => const Login(),
                  );
                },
              );
            },
          ),
        );
      } else if (value.statusCode == 403) {
        AppSnackbar.snackbar(title: "Error", message: data["error"]);
      }
    }).catchError((err) {
      debugPrint(err);
    });
  }
}
