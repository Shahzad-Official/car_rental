import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/registration_controllers/forget_password_controller.dart';
import 'package:car_rental/controllers/registration_controllers/signup_controller.dart';
import 'package:car_rental/views/registration_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_field.dart';
import '../../widgets/app_text.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final ForgetPasswordController _controller = Get.put(ForgetPasswordController());

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
                      AppSpacing.heightSpace20,
                      Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: _.profile == null ? null : FileImage(_.profile!),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                _.pickProfile();
                              },
                              child: Card(
                                elevation: 12,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.heightSpace30,
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
                      AppField(
                        controller: _.address,
                        readOnly: true,
                        onTap: () async {
                          await _.pickLocation(context);
                        },
                        hintText: "Location",
                        suffixIcon: const Icon(
                          Icons.location_on_rounded,
                        ),
                      ),
                      AppSpacing.heightSpace30,
                      PhoneField(
                        controller: _.phone,
                        hintText: "Phone Number",
                        onChanged: (number) {
                          _.phoneCode = number.countryCode;
                          _.phoneCountry = number.countryISOCode;
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
                            _.isObsecure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
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
                            _.isObsecureCPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          ),
                        ),
                      ),
                      AppSpacing.heightSpace30,
                      AppButton(
                        isLoading: _.isLoading,
                        onTap: () async {
                          _controller.email = _.email;
                          _controller.phone = _.phone;
                          _controller.countryCode = _.phoneCode;
                          await _.signUp();
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
