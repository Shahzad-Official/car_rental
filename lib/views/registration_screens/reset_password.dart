import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/registration_controllers/forget_password_controller.dart';
import 'package:car_rental/views/registration_screens/login.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_field.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final ForgetPasswordController _controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/reset_pass_vector.svg",
                width: 170,
              ),
              AppSpacing.heightSpace20,
              const AppText(
                text: "Reset Password",
                fontWeight: FontWeight.w800,
                fontSize: 25,
              ),
              AppSpacing.heightSpace10,
              const AppText(
                textAlign: TextAlign.center,
                text:
                    "Here's a tip: Use a combination of Numbers, Uppercase, lowercase and Special characters",
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppSpacing.heightSpace40,
              GetBuilder<ForgetPasswordController>(
                init: ForgetPasswordController(),
                initState: (_) {},
                builder: (_) {
                  return AppField(
                    hintText: "New Password",
                    controller: _.password,
                    isObsecure: _.isObsecure,
                    inputType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _.viewPassword();
                      },
                      icon: Icon(
                        _.isObsecure
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  );
                },
              ),
              AppSpacing.heightSpace30,
              AppButton(
                onTap: () {
                  _controller.resetPassword();
                  Get.defaultDialog(
                    title: "Passwor has been reset successfully",
                    content: LottieBuilder.asset(
                      "assets/animations/verified.json",
                      repeat: false,
                      onLoaded: (p0) {
                        Future.delayed(
                          p0.duration,
                          () {
                            Get.offAll(
                              () => const Login(),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                text: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
