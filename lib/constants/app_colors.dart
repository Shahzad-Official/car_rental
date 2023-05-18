import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF205EFD);
  Map<int, Color> color = {
    50: const Color.fromRGBO(32, 94, 253, .1),
    100: const Color.fromRGBO(32, 94, 253, .2),
    200: const Color.fromRGBO(32, 94, 253, .3),
    300: const Color.fromRGBO(32, 94, 253, .4),
    400: const Color.fromRGBO(32, 94, 253, .5),
    500: const Color.fromRGBO(32, 94, 253, .6),
    600: const Color.fromRGBO(32, 94, 253, .7),
    700: const Color.fromRGBO(32, 94, 253, .8),
    800: const Color.fromRGBO(32, 94, 253, .9),
    900: const Color.fromRGBO(32, 94, 253, 1),
  };
  MaterialColor get colorCustom => MaterialColor(0xFF205EFD, color);
}
