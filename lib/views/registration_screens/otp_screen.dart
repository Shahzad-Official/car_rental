import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/registration_controllers/forget_password_controller.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final bool isSignUp;
  OtpScreen({
    Key? key,
    this.isSignUp = false,
  }) : super(key: key);
  final ForgetPasswordController _controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSpacing.heightSpace40,
                Center(
                  child: SvgPicture.asset(
                    "assets/icons/otp_vector.svg",
                    width: 200,
                  ),
                ),
                AppSpacing.heightSpace50,
                const AppText(
                  text: "OTP Verification",
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                AppSpacing.heightSpace10,
                const AppText(
                  text: "We have sent one time password to",
                ),
                AppSpacing.heightSpace5,
                const AppText(
                  text: "this Phone Number",
                ),
                AppSpacing.heightSpace5,
                AppText(
                  text: _controller.completeNumber,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                AppSpacing.heightSpace5,
                const AppText(
                  text: "Enter  OTP  to verify your Phone Number",
                ),
                AppSpacing.heightSpace30,
                Pinput(
                  controller: _controller.pin,
                  defaultPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(2, 2),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(-2, -2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 155, 182, 248),
                    ),
                  ),
                ),
                AppSpacing.heightSpace30,
                GetBuilder<ForgetPasswordController>(
                  init: ForgetPasswordController(),
                  builder: (_) {
                    return AppButton(
                      isLoading: _.isVerificationLoading,
                      onTap: () async {
                        await _.verifyOtp(isSignUp);
                      },
                      text: "Verify",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
