import 'dart:convert';

import 'package:car_rental/constants/api_constants.dart';
import 'package:car_rental/models/user_model.dart';
import 'package:car_rental/utils/app_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import '../views/home/main_page.dart';

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
        // debugPrint("login Data => ${value.body}");
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
          AppSnackbar.snackbar(title: "Error", message: data['error']);
        }
      },
    ).catchError(
      (err) {
        debugPrint(err.toString());
      },
    );
  }
}
