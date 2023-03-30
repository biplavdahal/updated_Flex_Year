import 'package:flutter/material.dart';

import '../../../../data_models/attendance_report_summary.data.dart';

class LastCard extends StatelessWidget {
  final AttendanceReportSummaryData report;

  const LastCard(
    this.report, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Total(Hrs)",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
                child: Row(
              children: [Text(report.workingHours.toString())],
            ))
          ],
        ),
      ),
    );
  }
}
