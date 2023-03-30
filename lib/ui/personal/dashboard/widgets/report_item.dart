import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

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
          : report.holiday != null
              ? Colors.amber.shade100
              : report.totalWorkingHours == '0.00' ||
                      report.totalWorkingHours == '00:00'
                  ? Colors.red.shade100
                  : Colors.green.shade100,
      margin: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  weekDayFromDateString(report.date) +
                      " - " +
                      (index + 1).toString(),
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
                  report.checkInTime == '00:00' ? '-' : report.checkInTime,
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
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  report.weekend.isNotEmpty
                      ? "Weekend"
                      : report.holiday != null
                          ? "Holiday"
                          : report.totalWorkingHours == '0.00' ||
                                  report.totalWorkingHours == '00:00'
                              ? 'Absent'
                              : report.totalWorkingHours,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: report.weekend.isNotEmpty
                        ? AppColor.primary
                        : report.holiday != null
                            ? AppColor.primary
                            : report.totalWorkingHours == '0.00' ||
                                    report.totalWorkingHours == '00:00'
                                ? Colors.red
                                : Colors.green,
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
