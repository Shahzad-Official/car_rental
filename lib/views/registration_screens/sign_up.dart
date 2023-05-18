import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/registration_controllers/forget_password_controller.dart';
import 'package:car_rental/controllers/registration_controllers/signup_controller.dart';
import 'package:car_rental/views/registration_screens/login.dart';
import 'package:car_rental/views/registration_screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_field.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/app_text.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final ForgetPasswordController _controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppSpacing.defaultPadding,
            child: GetBuilder<SignupController>(
              init: SignupController(),
              builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: AppLogo(
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const AppText(
                        text: "Sign Up",
                        fontSize: 30,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      AppSpacing.heightSpace10,
                      const AppText(
                        text: "Register a New Account",
                        fontSize: 20,
                      ),
                      AppSpacing.heightSpace50,
                      AppField(
                        controller: _.firstname,
                        hintText: "FirstName",
                        inputType: TextInputType.emailAddress,
                      ),
                      AppSpacing.heightSpace30,
                      AppField(
                        controller: _.lastname,
                        hintText: "LastName",
                        inputType: TextInputType.emailAddress,
                      ),
                      AppSpacing.heightSpace30,
                      PhoneField(
                        controller: _.phone,
                        hintText: "Phone Number",
                        onChanged: (number) {
                          _.phoneCode = number.countryCode;
                        },
                      ),
                      AppSpacing.heightSpace30,
                      AppField(
                        controller: _.email,
                        hintText: "Email",
                        inputType: TextInputType.emailAddress,
                      ),
                      AppSpacing.heightSpace30,
                      AppField(
                        controller: _.password,
                        hintText: "Password",
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
                      ),
                      AppSpacing.heightSpace30,
                      AppField(
                        controller: _.cPassword,
                        hintText: "Retype Password",
                        isObsecure: _.isObsecureCPassword,
                        inputType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _.viewCPassword();
                          },
                          icon: Icon(
                            _.isObsecureCPassword
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                      ),
                      AppSpacing.heightSpace30,
                      AppButton(
                        onTap: () {
                          _controller.phone = _.phone;
                          _controller.countryCode = _.phoneCode;
                          Get.to(
                            () => OtpScreen(
                              isSignUp: true,
                            ),
                          );
                        },
                        text: "Sign Up",
                      ),
                      AppSpacing.heightSpace20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppText(
                            text: "Already have an account?",
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAll(
                                () => const Login(),
                              );
                            },
                            child: const AppText(
                              text: "Sign In",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
