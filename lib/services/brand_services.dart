import 'dart:convert';

import 'package:car_rental/models/brand_model.dart';
import 'package:car_rental/models/car_model.dart';
import 'package:dio/dio.dart';
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
      Uri.parse(ApiConstants.baseUrl + ApiConstants.brand),
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
        debugPrint("All Brands service error=> $err");
      },
    );
  }

  CarModel carModel = CarModel();
  getBrandCars(String brandId) async {
    await Dio()
        .get(
      ApiConstants.baseUrl + ApiConstants.brandCars,
      queryParameters: {
        "brand": brandId,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    )
        .then((value) {
      debugPrint("Brand cars data=> ${jsonEncode(value.data)}");
      carModel = CarModel.fromJson(value.data);
    }).catchError((err) {
      if (err.response != null) {
        AppSnackbar.snackbar(message: err.response.data['message'].toString(), title: "Error");
      }
      debugPrint("Brand cars error=> $err");
    });
  }
}
