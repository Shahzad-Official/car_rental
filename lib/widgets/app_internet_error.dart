import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppInternetError extends StatelessWidget {
  const AppInternetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText(
          text:
              "Your internet is not connected!\nPlease check your internet connection?",
          textAlign: TextAlign.center,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      ),
    );
  }
}
