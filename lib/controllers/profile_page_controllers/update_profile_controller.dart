import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController profilePath = TextEditingController();
  File? profile;
  pickProfile() async {
    await FilePicker.platform
        .pickFiles(
      type: FileType.image,
    )
        .then((value) {
      if (value != null) {
        profilePath.text = value.files.first.path!;
        profile = File(value.files.first.path!);
        update();
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }
}
