import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/registration_controllers/forget_password_controller.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_field.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final ForgetPasswordController _controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: "Forget Password",
        ),
      ),
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/icons/forget_pass_vector.svg",
                width: 200,
              ),
            ),
            AppSpacing.heightSpace40,
            const AppText(
              text: "Forget Password?",
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            AppSpacing.heightSpace10,
            const AppText(
              text: "Enter your phone# to recieve OTP?",
              fontSize: 16,
            ),
            AppSpacing.heightSpace30,
            PhoneField(
              controller: _controller.phone,
              hintText: "Phone Number",
              onChanged: (number) {
                _controller.countryCode = number.countryCode;
              },
            ),
            AppSpacing.heightSpace30,
            GetBuilder<ForgetPasswordController>(
              init: ForgetPasswordController(),
              initState: (_) {},
              builder: (_) {
                return AppButton(
                  onTap: () {
                    _.sendOtp();
                  },
                  text: "Continue",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
