import 'dart:io';

import 'package:car_rental/services/registration_services.dart';
import 'package:car_rental/utils/app_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';
import '../main.dart';

class ProfileServices {
  final RegistrationServices _services = RegistrationServices();
  String get token => box.get("loginToken");
  signUp({
    required File profile,
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phoneCode,
    required String phoneCountry,
    required String phoneNumber,
    required String address,
    required String latitude,
    required String longitude,
  }) async {
    Map<String, dynamic> data = {
      "profile": await dio.MultipartFile.fromFile(profile.path),
      "email": email,
      "password": password,
      "firstname": firstname,
      "lastname": lastname,
      "phoneCode": phoneCode,
      "phoneCountry": phoneCountry,
      "phoneNumber": phoneNumber,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
    };

    await Dio()
        .post(
      ApiConstants.baseUrl + ApiConstants.signUp,
      data: FormData.fromMap(data),
    )
        .then((value) async {
      if (value.statusCode == 201) {
        await _services.sendOtp(
          email: email,
          number: phoneNumber,
          phone: phoneCode + phoneNumber,
          phoneCode: phoneCode,
          isSignUp: true,
        );
      } else {
        debugPrint(value.data);
      }
    }).catchError((err) {
      debugPrint(err.toString());
      debugPrint(err.response.data.toString());
    });
  }

  updateProfile({
    required String firstname,
    required String lastname,
    required String email,
    required String phoneCode,
    required String phoneNumber,
    required String phoneCountry,
    File? profile,
    required String profilePath,
  }) async {
    Map<String, Object> data = {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "phoneCode": phoneCode,
      "phoneCountry": phoneCountry,
      "phoneNumber": phoneNumber,
      "profilePath": profilePath,
      "profile": profile == null ? profilePath : await dio.MultipartFile.fromFile(profile.path),
    };

    await Dio()
        .put(
      ApiConstants.baseUrl + ApiConstants.updateProfile,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
      data: FormData.fromMap(data),
    )
        .then((value) {
      var data = (value.data);
      debugPrint("profile updated=> $data");
      var userData = (data['data']);
      AppSnackbar.snackbar(title: "Message", message: data['message']);

      box.put("userData", userData);
    }).catchError((err) {
      debugPrint(err.toString());
      debugPrint(err.response.data.toString());
    });
  }
}
