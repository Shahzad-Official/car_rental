import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';
import '../main.dart';

class ProfileServices {
  String get token => box.get("loginToken");
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
      "profile": profile == null
          ? profilePath
          : await dio.MultipartFile.fromFile(profile.path),
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

      box.put("userData", userData);
    }).catchError((err) {
      debugPrint(err.toString());
      debugPrint(err.response.data.toString());
    });
  }
}
