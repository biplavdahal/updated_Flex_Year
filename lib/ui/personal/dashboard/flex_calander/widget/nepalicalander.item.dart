import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../data_models/attendance_report.data.dart';

class NepaliCalanderItems extends StatefulWidget {
  final List<AttendanceReportData> monthlyReport;

  const NepaliCalanderItems({
    Key? key,
    required this.monthlyReport,
  }) : super(key: key);

  @override
  State<NepaliCalanderItems> createState() => _NepaliCalanderItemsState();
}

class _NepaliCalanderItemsState extends State<NepaliCalanderItems> {
  @override
  Widget build(BuildContext context) {
    final NepaliCalendarController _nepaliCalendarController =
        NepaliCalendarController();
    return CleanNepaliCalendar(
        controller: _nepaliCalendarController,
        headerDayType: HeaderDayType.halfName,
        initialDate: NepaliDateTime.now(),
        calendarStyle: CalendarStyle(selectedColor: AppColor.primary));
  }
}
