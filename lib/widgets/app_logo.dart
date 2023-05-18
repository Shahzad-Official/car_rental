import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height, width;
  const AppLogo({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Theme.of(context).brightness == Brightness.light
          ? "assets/images/logo.png"
          : "assets/images/logo_dark.png",
      height: height,
      width: width,
    );
  }
}
