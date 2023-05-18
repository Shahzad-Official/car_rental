import 'package:car_rental/constants/app_colors.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final double? height, width;
  final bool isLoading;
  const AppButton({
    Key? key,
    this.onTap,
    required this.text,
    this.height,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height ?? 60,
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: isLoading
              ? const SpinKitThreeBounce(
                  size: 25,
                  color: Colors.white,
                )
              : AppText(
                  text: text,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
