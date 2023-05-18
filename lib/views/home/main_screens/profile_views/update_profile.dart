import 'dart:convert';

import 'package:car_rental/constants/api_constants.dart';
import 'package:car_rental/controllers/profile_page_controllers/update_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_spacing.dart';
import '../../../../main.dart';
import '../../../../models/user_model.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/app_text.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final UpdateProfileController _controller =
      Get.put(UpdateProfileController());
  initializeData() {
    _controller.firstName.text = userData.data!.firstname.toString();
    _controller.lastName.text = userData.data!.lastname.toString();
    _controller.email.text = userData.data!.email.toString();
    _controller.profilePath.text = userData.data!.profile.toString();
  }

  UserModel userData = UserModel();
  @override
  void initState() {
    var data = jsonEncode(box.get("userData"));

    userData = UserModel.fromJson(jsonDecode(data));
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: "Update Profile"),
      ),
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: ListView(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    "${ApiConstants.baseUrl}/${userData.data!.profile!}",
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Card(
                      elevation: 10,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.firstName,
              hintText: "First Name",
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.lastName,
              hintText: "Last Name",
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.email,
              hintText: "email",
            ),
          ],
        ),
      ),
    );
  }
}
