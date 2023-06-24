import 'package:car_rental/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class AppField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon, prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool isObsecure;
  final TextInputType? inputType;
  final void Function(String value)? onChanged;
  final int? maxLength, maxLines;
  final bool readOnly;
  final Callback? onTap;
  const AppField({
    Key? key,
    this.contentPadding,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.inputType,
    this.isObsecure = false,
    this.prefixIcon,
    this.onChanged,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      textAlign: TextAlign.start,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChanged,
      controller: controller,
      obscureText: isObsecure,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: AppColors.primaryColor.withOpacity(0.05),
        hintText: hintText,
        hintStyle: GoogleFonts.dmSans(),
        labelStyle: GoogleFonts.dmSans(),
        suffixIcon: suffixIcon,
        labelText: hintText,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.5,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool isObsecure;
  final String? initialCountryCode;
  final void Function(PhoneNumber number)? onChanged;
  const PhoneField({
    Key? key,
    this.contentPadding,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.isObsecure = false,
    this.onChanged,
    this.initialCountryCode = "PK",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: initialCountryCode,
      onChanged: onChanged,
      controller: controller,
      obscureText: isObsecure,
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: AppColors.primaryColor.withOpacity(0.05),
        hintText: hintText,
        hintStyle: GoogleFonts.dmSans(),
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.5,
            color: AppColors.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.5,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.5,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class AppDropdownField extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final String? hintText;
  final void Function(dynamic value) onChanged;

  const AppDropdownField({
    Key? key,
    required this.items,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: 250,
      elevation: 12,
      borderRadius: BorderRadius.circular(10),
      items: items,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primaryColor.withOpacity(0.05),
        hintText: hintText,
        hintStyle: GoogleFonts.dmSans(),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.5,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
