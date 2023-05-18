import 'dart:convert';

import 'package:car_rental/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';

import '../constants/api_constants.dart';
import '../utils/app_snackbar.dart';

class BrandServices {
  Box box = Hive.box("Data");
  String get token => box.get("loginToken");
  BrandModel brandModel = BrandModel();
  getAllBrands() async {
    await get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.allBrands),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    ).then(
      (value) {
        var data = jsonDecode(value.body);
        debugPrint("All Brands Data => $data");
        if (value.statusCode == 200) {
          brandModel = BrandModel.fromJson(data);
        } else {
          AppSnackbar.snackbar(
            title: "Error",
            message: value.body.toString(),
          );
        }
      },
    ).catchError(
      (err) {
        debugPrint("All Cars service error=> $err");
      },
    );
  }
}
