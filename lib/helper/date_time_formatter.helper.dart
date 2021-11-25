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

String getCurrentDateTime() {
  DateTime now = DateTime.now();

  return "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}";
}

String hourFormatter(String unformattedHour) {
  final _token = unformattedHour.split(":");

  String formattedHour = "";

  if (_token[0] != "00") {
    formattedHour = "${_token[0]} Hour(s) ";
  }

  if (_token[1] != "00") {
    formattedHour += "${_token[1]} Minute(s)";
  }

  return formattedHour;
}

String lastDateOfMonth() {
  var now = DateTime.now();

  var lastDayDateTime = (now.month < 12)
      ? DateTime(now.year, now.month + 1, 0)
      : DateTime(now.year + 1, 1, 0);

  return "${lastDayDateTime.year}-${lastDayDateTime.month}-${lastDayDateTime.day}";
}
