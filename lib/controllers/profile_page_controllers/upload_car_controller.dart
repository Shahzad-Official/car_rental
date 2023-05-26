import 'dart:io';

import 'package:car_rental/services/car_services.dart';
import 'package:car_rental/utils/app_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UploadCarController extends GetxController {
  TextEditingController carName = TextEditingController();
  TextEditingController brandId = TextEditingController();
  TextEditingController noOfSeats = TextEditingController();
  TextEditingController maxSpeed = TextEditingController();
  TextEditingController pricePerDay = TextEditingController();
  TextEditingController priceHalfWeek = TextEditingController();
  TextEditingController pricePerWeek = TextEditingController();
  TextEditingController description = TextEditingController();
  final CarServices _carServices = CarServices();
  File? carThumbnail;
  pickImage() async {
    await FilePicker.platform
        .pickFiles(
      allowCompression: true,
      type: FileType.image,
    )
        .then((value) {
      if (value != null) {
        carThumbnail = File(value.files.first.path!);
        update();
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }

  bool isLoading = false;
  uploadCarData(context) async {
    if (carThumbnail == null) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please select thumbnail image!");
    } else if (carName.text.isEmpty) {
      AppSnackbar.snackbar(title: "Error", message: "Please enter carName!");
    } else if (brandId.text.isEmpty) {
      AppSnackbar.snackbar(title: "Error", message: "Please select brand!");
    } else if (noOfSeats.text.isEmpty) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please enter seats of car!");
    } else if (maxSpeed.text.isEmpty) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please enter car max speed!");
    } else if (pricePerDay.text.isEmpty) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please enter car rent per day!");
    } else if (priceHalfWeek.text.isEmpty) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please enter car rent for half week!");
    } else if (pricePerWeek.text.isEmpty) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please enter car one week rent!");
    } else if (description.text.isEmpty) {
      AppSnackbar.snackbar(
          title: "Error", message: "Please enter some car description!");
    } else {
      isLoading = true;
      update();
      await _carServices.createCar(
        context,
        carName: carName.text,
        description: description.text,
        pricePerDay: pricePerDay.text,
        priceHalfWeek: priceHalfWeek.text,
        pricePerWeek: pricePerWeek.text,
        maxSpeed: maxSpeed.text,
        brandId: brandId.text,
        noOfSeats: noOfSeats.text,
        thumbnail: carThumbnail!,
      );

      isLoading = false;
      update();
    }
  }
}
