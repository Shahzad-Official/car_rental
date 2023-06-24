import 'dart:convert';

import 'package:car_rental/main.dart';
import 'package:car_rental/views/home/main_screens/profile_views/create_car.dart';
import 'package:car_rental/views/home/main_screens/profile_views/my_cars.dart';
import 'package:car_rental/views/home/main_screens/profile_views/update_profile.dart';
import 'package:car_rental/views/registration_screens/login.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_spacing.dart';
import '../../../models/user_model.dart';
import '../../../widgets/app_cached_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData userData = UserData();
  @override
  void initState() {
    var data = jsonEncode(box.get("userData"));

    userData = UserData.fromJson(jsonDecode(data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                margin: const EdgeInsets.all(15),
                height: 300,
                width: double.maxFinite,
                child: AppCachedImage(
                  url: userData.profile.toString(),
                ),
              ),
            ),
            AppSpacing.heightSpace20,
            Card(
              elevation: 5,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: ListTile(
                onTap: () {
                  Get.to(
                    () => const UpdateProfile(),
                  );
                },
                leading: SvgPicture.asset(
                  "assets/icons/user.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                ),
                title: const AppText(
                  text: "Update profile",
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            AppSpacing.heightSpace20,
            Card(
              elevation: 5,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: ListTile(
                onTap: () {
                  Get.to(
                    () => const CreateCar(),
                  );
                },
                leading: SvgPicture.asset(
                  "assets/icons/upload.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                ),
                title: const AppText(
                  text: "Upload a Car",
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            AppSpacing.heightSpace20,
            Card(
              elevation: 5,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: ListTile(
                onTap: () {
                  Get.to(
                    () => const MyCars(),
                  );
                },
                leading: SvgPicture.asset(
                  "assets/icons/collection.svg",
                  height: 40,
                  width: 40,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                ),
                title: const AppText(
                  text: "My Cars Collection",
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                box.put("isLogedin", false);
                Get.deleteAll();
                Get.offAll(
                  () => const Login(),
                );
              },
              leading: const Icon(
                Icons.power_settings_new_rounded,
                color: Colors.red,
              ),
              title: const AppText(
                text: "Log Out",
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
