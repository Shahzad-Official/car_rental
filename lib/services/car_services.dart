import 'dart:convert';
import 'dart:io';

import 'package:car_rental/constants/api_constants.dart';
import 'package:car_rental/models/car_model.dart';
import 'package:car_rental/utils/app_snackbar.dart';
import 'package:car_rental/views/home/main_page.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

class CarServices {
  Box box = Hive.box("Data");
  String get token => box.get("loginToken");
  CarModel carModel = CarModel();

  getAllCars() async {
    await get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllCars),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    ).then(
      (value) {
        var data = jsonDecode(value.body);
        debugPrint("All Cars Data => $data");
        if (value.statusCode == 200) {
          carModel = CarModel.fromJson(data);
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

  getMyCars() async {
    await get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.myCars),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    ).then(
      (value) {
        var data = jsonDecode(value.body);
        debugPrint("All Cars Data => $data");
        if (value.statusCode == 200) {
          carModel = CarModel.fromJson(data);
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

  createCar(
    context, {
    required String carName,
    required String description,
    required String pricePerDay,
    required String priceHalfWeek,
    required String pricePerWeek,
    required String maxSpeed,
    required String brandId,
    required String noOfSeats,
    required File thumbnail,
  }) async {
    Map<String, Object> data = {
      "carname": carName,
      "description": description,
      "pricePerDay": pricePerDay,
      "priceHalfWeek": priceHalfWeek,
      "pricePerWeek": pricePerWeek,
      "maxSpeed": maxSpeed,
      "brandId": brandId,
      "noOfSeats": noOfSeats,
      "thumbnail": await dio.MultipartFile.fromFile(
        thumbnail.path,
        filename: thumbnail.path.split("/").last,
      ),
    };
    await Dio()
        .post(
      ApiConstants.baseUrl + ApiConstants.createCar,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
      data: FormData.fromMap(data),
    )
        .then((value) {
      debugPrint(value.data.toString());
      AppSnackbar.snackbar(title: "Success", message: value.data['message']);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    }).catchError((err) {
      debugPrint(err.toString());
      debugPrint(err.response.data.toString());
      AppSnackbar.snackbar(
        title: "Error",
        message: err.response.data['message'].toString(),
      );
    });
  }
}
