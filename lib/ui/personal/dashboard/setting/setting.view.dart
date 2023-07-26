import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/setting/setting.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../data_models/attendance_report.data.dart';

class SettingView extends StatefulWidget {
  static String tag = 'setting-view';

  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return View<SettingModel>(
      enableTouchRepeal: true,
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Calander View'),
            ),
            body: Card(child: _buildCalendarEnglish(model.monthlyReport)));
      },
    );
  }

  Widget _buildCalendarEnglish(List<AttendanceReportData> monthlyReport) {
    final today = DateTime.now();
    return TableCalendar(
      firstDay: DateTime.utc(1990, 10, 16),
      lastDay: DateTime.utc(2080, 3, 14),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.sunday) {
            final text = DateFormat.E().format(day);
            return Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
        },
        selectedBuilder: (context, date, _) {
          final matchingReport = monthlyReport.firstWhere(
            (report) {
              final reportDate = DateTime.parse(report.date);
              return DateTime(
                      reportDate.year, reportDate.month, reportDate.day) ==
                  date;
            },
            orElse: () => AttendanceReportData(
              date: date.toString(),
              checkInTime: '-',
              checkOutTime: '-',
              lunchIn: '-',
              lunchOut: '-',
              lunchDuration: '-',
              weekend: '-',
              workingHours: '-',
              totalWorkingHours: '-',
            ),
          );

          return Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(date.day.toString()),
                if (date.isBefore(today))
                  Text('Check-In: ${matchingReport.checkInTime}'),
                Text('Check-Out: ${matchingReport.checkOutTime}'),
              ],
            ),
          );
        },
        defaultBuilder: (context, date, _) {
          final matchingReport = monthlyReport.firstWhere(
            (report) {
              final reportDate = DateTime.parse(report.date);
              return DateTime(
                      reportDate.year, reportDate.month, reportDate.day) ==
                  date;
            },
            orElse: () => AttendanceReportData(
              date: date.toString(),
              checkInTime: '-',
              checkOutTime: '-',
              lunchIn: '-',
              lunchOut: '-',
              lunchDuration: '-',
              weekend: '-',
              workingHours: '-',
              totalWorkingHours: '-',
            ),
          );

          return Container(
            alignment: Alignment.center,
            color: date.isBefore(today)
                ? matchingReport.weekend.isNotEmpty
                    ? const Color.fromARGB(255, 139, 213, 245)
                    : matchingReport.holiday != null
                        ? Colors.amber.shade100
                        : matchingReport.checkInTime == "00:00" &&
                                matchingReport.checkOutTime == "00:00"
                            ? Colors.white70
                            : _getCardColor(matchingReport.totalWorkingHours)
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(date.day.toString()),
                if (date.isBefore(today)) ...[
                  Text(
                    'In: ${matchingReport.checkInTime}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    'Out: ${matchingReport.checkOutTime}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ]
              ],
            ),
          );
        },
      ),
      onDaySelected: (selectedDay, focusedDay) {},
    );
  }
}

Color _getCardColor(String totalWorkingHours) {
  double hours = double.tryParse(totalWorkingHours) ?? 0.0;
  return hours < 8 ? Colors.red.shade100 : Colors.green.shade100;
}

Color _getTextColor(String totalWorkingHours) {
  double hours = double.tryParse(totalWorkingHours) ?? 0.0;
  return hours > 8 ? Colors.green : Colors.red;
}
