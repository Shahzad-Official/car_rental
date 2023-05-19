import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/registration_controllers/forget_password_controller.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_field.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({
    Key? key,
  }) : super(key: key);
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
              GetBuilder<ForgetPasswordController>(
                init: ForgetPasswordController(),
                builder: (_) {
                  return AppButton(
                    isLoading: _.isLoading,
                    onTap: () async {
                      await _.resetPassword();
                    },
                    text: "Submit",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
