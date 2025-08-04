import 'package:intl/intl.dart';

class DateTimeUtils {
  static final DateTimeUtils _instance = DateTimeUtils._internal();

  factory DateTimeUtils() => _instance;

  DateTimeUtils._internal();

  String formatMessageDateTime(DateTime dateTime) {
    DateTime now = DateTime.now();

    bool isToday = now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;
    if (isToday) {
      return DateFormat('h:mm a').format(dateTime);
    }
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
