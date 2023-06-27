import 'dart:async';

import 'package:car_rental/views/home/main_page.dart';
import 'package:car_rental/views/registration_screens/login.dart';
import 'package:car_rental/widgets/app_internet_error.dart';
import 'package:car_rental/widgets/app_logo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Box box = Hive.box("Data");
  bool get isLogedin => box.get("isLogedin");
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (box.get("isLogedin") != null && isLogedin) {
        Get.offAll(
          () => StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data == ConnectivityResult.none) {
                return const AppInternetError();
              } else {
                return const MainPage();
              }
            },
          ),
        );
      } else {
        Get.offAll(
          () => const Login(),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(
              height: 350,
              width: 350,
            ),
            SpinKitFadingCube(
              size: 50,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
