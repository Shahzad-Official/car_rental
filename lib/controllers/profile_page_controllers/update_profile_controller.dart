import 'dart:io';

import 'package:car_rental/services/profile_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneCode = TextEditingController();
  TextEditingController phoneCountry = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController profilePath = TextEditingController();
  File? profile;
  final ProfileServices _profileServices = ProfileServices();
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
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }

  bool isLoading = false;
  updateProfile() async {
    isLoading = true;
    update();
    await _profileServices.updateProfile(
      firstname: firstName.text,
      lastname: lastName.text,
      email: email.text,
      phoneCode: phoneCode.text,
      phoneCountry: phoneCountry.text,
      phoneNumber: phoneNumber.text,
      profilePath: profilePath.text,
      profile: profile,
    );
    isLoading = false;
    update();
  }
}
