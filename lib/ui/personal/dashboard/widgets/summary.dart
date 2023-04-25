import 'package:flex_year_tablet/data_models/attendance_report_summary.data.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final AttendanceReportSummaryData report;

  const Summary(
    this.report, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Total(hrs)",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              report.workingHours.toString(),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
