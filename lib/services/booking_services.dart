import 'dart:convert';

import 'package:car_rental/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';

class BookingServices {
  Box box = Hive.box("Data");
  String get token => box.get("loginToken");
  makeBooking({
    required String carId,
    required String bookedOn,
    required String duration,
    required String expiredOn,
  }) async {
    var body = jsonEncode({
      "carId": carId,
      "bookedOn": bookedOn,
      "expiredOn": expiredOn,
      "duration": duration,
    });
    await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.booking),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    ).then((value) {
      if (value.statusCode == 200) {
        Get.back();
      }
    }).catchError((err) {
      debugPrint("Booking error=> $err");
    });
  }

  getMyBookings() async {
    await get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.booking),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    ).then((value) {
      print(value.body);
    }).catchError((err) {
      debugPrint("My booking error=> $err");
    });
  }
}
