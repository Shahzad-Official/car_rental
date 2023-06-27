import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(String pattern, {required String date}) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat(pattern).format(dateTime);
  }
}
