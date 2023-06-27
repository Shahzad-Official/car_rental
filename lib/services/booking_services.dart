import 'dart:convert';

import 'package:car_rental/constants/api_constants.dart';
import 'package:car_rental/models/booking_model.dart';
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
    required String price,
  }) async {
    var body = jsonEncode({
      "carId": carId,
      "bookedOn": bookedOn,
      "expiredOn": expiredOn,
      "duration": duration,
      "price": price,
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

  List<BookingData> allBookings = [];
  getMyBookings() async {
    allBookings.clear();
    await get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.booking),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    ).then((value) {
      debugPrint(value.body.toString());
      var data = jsonDecode(value.body);
      if (value.statusCode == 200) {
        BookingModel bookingModel = BookingModel.fromJson(data);
        allBookings = bookingModel.bookingData!
            .where(
              (element) => DateTime.parse(element.expiredOn.toString()).isAfter(
                DateTime.now(),
              ),
            )
            .toList();
      }
    }).catchError((err) {
      debugPrint("My booking error=> $err");
    });
  }
}
