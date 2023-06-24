import 'dart:io';

import 'package:car_rental/services/location_services.dart';
import 'package:car_rental/services/profile_services.dart';
import 'package:car_rental/utils/app_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignupController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  LatLng? latLng;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  String phoneCode = "";
  String phoneCountry = "";

  final ProfileServices _profileServices = ProfileServices();
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  bool isObsecure = true;
  viewPassword() {
    isObsecure = !isObsecure;
    update();
  }

  bool isObsecureCPassword = true;
  viewCPassword() {
    isObsecureCPassword = !isObsecureCPassword;
    update();
  }

  File? profile;
  pickProfile() async {
    await FilePicker.platform
        .pickFiles(
      type: FileType.image,
    )
        .then((value) {
      if (value != null) {
        profile = File(value.files.first.path!);
        update();
      }
    });
  }

  bool isLoading = false;
  signUp() async {
    if (profile == null) {
      AppSnackbar.snackbar(title: "Error", message: "Pick your profile image!");
    } else if (firstname.text.isEmpty || lastname.text.isEmpty || firstname.text.length < 3) {
      AppSnackbar.snackbar(title: "Error", message: "Enter your valid name!");
    } else if (address.text.isEmpty || address.text.contains("loading")) {
      AppSnackbar.snackbar(title: "Error", message: "Please select your location!");
    } else if (phone.text.isEmpty) {
      AppSnackbar.snackbar(title: "Error", message: "Enter your mobile number!");
    } else if (email.text.isEmpty || !email.text.isEmail) {
      AppSnackbar.snackbar(title: "Error", message: "Enter your valid email!");
    } else if (password.text.isEmpty || !regex.hasMatch(password.text)) {
      AppSnackbar.snackbar(
          title: "Error",
          duration: const Duration(
            seconds: 4,
          ),
          message: "Enter your password having minimum 8 characters\nCombination of special character,uppercase ,lowercase and numbers");
    } else if (password.text != cPassword.text) {
      AppSnackbar.snackbar(title: "Error", message: "Check your confirm password!");
    } else {
      isLoading = true;
      update();
      await _profileServices.signUp(
        address: address.text,
        latitude: latLng!.latitude.toString(),
        longitude: latLng!.longitude.toString(),
        profile: profile!,
        email: email.text,
        password: password.text,
        firstname: firstname.text,
        lastname: lastname.text,
        phoneCode: phoneCode,
        phoneCountry: phoneCountry,
        phoneNumber: phone.text,
      );
      isLoading = false;
      update();
    }
  }

  pickLocation(context) async {
    address.text = "loading...";
    update();
    await LocationServices.showPlacePicker(context).then((value) {
      latLng = value.latLng;
      address.text = value.formattedAddress!;
    }).catchError((err) {
      debugPrint("location pick error => $err");
    });
  }
}
