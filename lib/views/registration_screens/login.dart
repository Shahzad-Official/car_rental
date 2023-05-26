import 'package:car_rental/constants/app_colors.dart';
import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/registration_controllers/login_controller.dart';

import 'package:car_rental/views/registration_screens/forget_password.dart';
import 'package:car_rental/views/registration_screens/sign_up.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_field.dart';
import 'package:car_rental/widgets/app_logo.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppSpacing.defaultPadding,
            child: GetBuilder<LoginController>(
              init: LoginController(),
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
                        text: "Sign In",
                        fontSize: 30,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      AppSpacing.heightSpace10,
                      const AppText(
                        text: "Please sign in to your account!",
                        fontSize: 20,
                      ),
                      AppSpacing.heightSpace50,
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(
                              () => ForgetPassword(),
                            );
                          },
                          child: const AppText(
                            text: "Forgot Password?",
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const AppText(
                            text: "Remember Me ",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Transform.scale(
                            scale: 0.75,
                            child: CupertinoSwitch(
                              activeColor: AppColors.primaryColor,
                              trackColor: Colors.grey,
                              value: _.isRemembered,
                              onChanged: (value) {
                                _.rememberMe(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.heightSpace30,
                      AppButton(
                        isLoading: _.isLoading,
                        onTap: () async {
                          await _.validateUser();
                        },
                        text: "Sign In",
                      ),
                      AppSpacing.heightSpace20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppText(
                            text: "Do not have an account?",
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAll(
                                () => SignUp(),
                              );
                            },
                            child: const AppText(
                              text: "Sign Up",
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
