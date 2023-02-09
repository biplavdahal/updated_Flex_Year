import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report_detail.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class MonthlyHorizontalReportItem extends StatelessWidget {
  final AttendanceReportDetailData report;
  final VoidCallback? onTap;

  const MonthlyHorizontalReportItem(
    this.report, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: AppColor.primary,
      textColor: AppColor.primary,
      childrenPadding: const EdgeInsets.only(left: 16, right: 16),
      tilePadding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      subtitle: Text("Total Working Hours : ${report.totalWorkingHours}"),
      title: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                report.totalWorkingHours.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total no. of days:"),
            Text(report.totalDays.toString())
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total no. of holidays:'),
            Text('report.attData!.totalOffDays.toString()'),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total no. of working days:'),
            Text('report.attData!.totalWorkingDays.toString()'),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total no. of present days:'),
            Text('report.attData!.totalPresentDays.toString()'),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total no. of absent days:'),
            Text('report.attData!.totalAbsentDays.toString()'),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total no. of requested leave days:'),
            Text('report.attData!.totalLeaveDays.toString()'),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total no. of working hours:'),
            Text('report.attData!.totalWorkingHours.toString()')
          ],
        )
      ],
    );
  }
}
