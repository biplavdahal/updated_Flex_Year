import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MonthlyHorizontalReportItems extends StatelessWidget {
  final AttendanceReportData report;
  final int index;
  final VoidCallback? onTap;

  const MonthlyHorizontalReportItems(
    this.report,
    this.index, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: report.weekend.isNotEmpty
          ? const Color.fromARGB(255, 139, 213, 245)
          : report.leaveType.toString().isNotEmpty
              ? Colors.amber.shade100
              : report.holiday != null
                  ? Colors.amber.shade100
                  : (report.checkInTime == "00:00" &&
                          report.checkOutTime == "00:00")
                      ? Colors.white70
                      : (report.checkInTime.isNotEmpty &&
                              report.checkOutTime == "00:00" &&
                              report.checkInTime != "00:00")
                          ? Colors.grey.shade300
                          : _getCardColor(report.totalWorkingHours),
      margin: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  weekDayFromDateString(report.date) +
                      "-" +
                      (index + 1).toString(),
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  report.checkInTime == '00:00' ? '-' : report.checkInTime,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  report.checkOutTime == '00:00' ? '-' : report.checkOutTime,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  report.weekend.isNotEmpty
                      ? "Weekend"
                      : report.leaveType.toString().isNotEmpty ||
                              report.leaveTime.toString().isNotEmpty
                          ? report.leaveType.toString() +
                              " " +
                              report.leaveTime.toString() +
                              " Leave"
                          : report.holiday != null
                              ? report.holiday.toString()
                              : (report.checkInTime.isNotEmpty &&
                                      report.checkOutTime == "00:00" &&
                                      report.checkInTime != "00:00")
                                  ? ''
                                  : report.totalWorkingHours == '0.00'
                                      ? 'Absent'
                                      : convertIntoHrs(
                                          report.totalWorkingHours),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: report.weekend.isNotEmpty
                        ? AppColor.primary
                        : report.leaveType.toString().isNotEmpty
                            ? AppColor.primary
                            : report.holiday != null
                                ? AppColor.primary
                                : (report.checkInTime.isNotEmpty &&
                                        report.checkOutTime.isEmpty)
                                    ? AppColor.primary
                                    : _getTextColor(report.totalWorkingHours),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Color _getCardColor(String totalWorkingHours) {
  double hours = double.tryParse(totalWorkingHours) ?? 0.0;
  return hours < 8.5 ? Colors.red.shade100 : Colors.green.shade100;
}

Color _getTextColor(String totalWorkingHours) {
  double hours = double.tryParse(totalWorkingHours) ?? 0.0;
  return hours >= 8.5 ? Colors.green : Colors.red;
}
