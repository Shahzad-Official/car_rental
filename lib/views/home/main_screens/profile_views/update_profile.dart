import 'dart:convert';

import 'package:car_rental/controllers/profile_page_controllers/update_profile_controller.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_spacing.dart';
import '../../../../main.dart';
import '../../../../models/user_model.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/app_text.dart';
import '../../main_page.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final UpdateProfileController _controller = Get.put(UpdateProfileController());
  initializeData() {
    _controller.firstName.text = userData.firstname.toString();
    _controller.lastName.text = userData.lastname.toString();
    _controller.email.text = userData.email.toString();
    _controller.profilePath.text = userData.profile.toString();
    _controller.phoneCode.text = userData.phoneCode.toString();
    _controller.phoneCountry.text = userData.phoneCountry.toString();
    _controller.phoneNumber.text = userData.phoneNumber.toString();
  }

  UserData userData = UserData();
  @override
  void initState() {
    var data = jsonEncode(box.get("userData"));

    userData = UserData.fromJson(jsonDecode(data));
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
                child: GetBuilder<UpdateProfileController>(
                  init: UpdateProfileController(),
                  builder: (_) {
                    return CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.transparent,
                      backgroundImage: _.profile != null ? FileImage(_.profile!) : null,
                      child: _.profile != null
                          ? Align(
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
                                      onPressed: () {
                                        _.pickProfile();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).textTheme.bodyMedium!.color,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Center(
                                  child: AppCachedImage(
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                    url: userData.profile.toString(),
                                  ),
                                ),
                                Align(
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
                                          onPressed: () {
                                            _.pickProfile();
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Theme.of(context).textTheme.bodyMedium!.color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
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
            AppSpacing.heightSpace30,
            PhoneField(
              initialCountryCode: _controller.phoneCountry.text,
              controller: _controller.phoneNumber,
              hintText: "Phone Number",
              onChanged: (number) {
                _controller.phoneCode.text = number.countryCode;
                _controller.phoneCountry.text = number.countryISOCode;
              },
            ),
            AppSpacing.heightSpace40,
            GetBuilder<UpdateProfileController>(
              init: UpdateProfileController(),
              initState: (_) {},
              builder: (_) {
                return AppButton(
                  isLoading: _.isLoading,
                  onTap: () async {
                    await _.updateProfile();
                    Get.deleteAll();
                    Get.offAll(
                      () => const MainPage(),
                    );
                  },
                  text: "Update",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
