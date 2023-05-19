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
        child: ListView(
          children: [
            AppSpacing.heightSpace30,
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
              text: "Enter your registered email and phone# to recieve OTP?",
              fontSize: 16,
              lineHeight: 2,
            ),
            AppSpacing.heightSpace30,
            AppField(
              controller: _controller.email,
              hintText: "Email",
            ),
            AppSpacing.heightSpace20,
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
                  isLoading: _.isLoading,
                  onTap: () async {
                    await _.sendOtp();
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
