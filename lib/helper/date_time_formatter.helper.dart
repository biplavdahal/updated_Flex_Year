import 'package:flex_year_tablet/data_models/date_format.data.dart';
import 'package:intl/intl.dart';

String formattedTime(String unformattedDateTime) {
  DateTime dateTime = DateTime.parse(unformattedDateTime);
  DateFormat format = DateFormat.jms();

  String formattedDate = format.format(dateTime);

  return formattedDate;
}

String formattedDate(String unformattedDateTime) {
  DateTime dateTime = DateTime.parse(unformattedDateTime);
  DateFormat format = DateFormat.yMMMMd();

  String formattedDate = format.format(dateTime);

  return formattedDate;
}
