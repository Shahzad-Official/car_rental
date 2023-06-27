import 'package:url_launcher/url_launcher.dart';

class UrlLauncherServices {
  static Future<bool> callUser(String number) async {
    return await launchUrl(
      Uri.parse("tel:$number"),
    );
  }

  static Future<bool> sendSms(String number) async {
    return await launchUrl(
      Uri.parse("sms:$number"),
    );
  }

  static Future<bool> sendEmail(String email) async {
    return await launchUrl(
      Uri.parse("mailto:$email"),
    );
  }
}
