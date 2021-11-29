import 'package:bestfriend/bestfriend.dart';

class AttendanceSummaryArguments extends Arguments {
  final String date;
  final String? clientId;

  AttendanceSummaryArguments({
    required this.date,
    this.clientId,
  });
}
