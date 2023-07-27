import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/setting/setting.model.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/setting/widget/setting.item.dart';
import 'package:flutter/material.dart';

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
              title: const Text('Flex Calander'),
            ),
            body: Column(
              children: [_buildCalendarEnglish(model)],
            ));
      },
    );
  }

  Widget _buildCalendarEnglish(SettingModel model) {
    DateTime today = DateTime.now();
    DateTime selectedDay = DateTime.now();
    DateTime focusedDay = DateTime.now();

    return CalanderItems();
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


  // selectedBuilder: (context, date, _) {
            //   final matchingReport = model.monthlyReport.firstWhere(
            //     (report) {
            //       final reportDate = DateTime.parse(report.date);
            //       return DateTime(
            //               reportDate.year, reportDate.month, reportDate.day) ==
            //           date;
            //     },
            //     orElse: () => AttendanceReportData(
            //       date: date.toString(),
            //       checkInTime: '-',
            //       checkOutTime: '-',
            //       lunchIn: '-',
            //       lunchOut: '-',
            //       lunchDuration: '-',
            //       weekend: '-',
            //       workingHours: '-',
            //       totalWorkingHours: '-',
            //     ),
            //   );

            //   return Container(
            //     alignment: Alignment.center,
            //     color: Colors.blue,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(date.day.toString()),
            //         if (date.isBefore(today))
            //           Text('Check-In: ${matchingReport.checkInTime}'),
            //         Text('Check-Out: ${matchingReport.checkOutTime}'),
            //       ],
            //     ),
            //   );
            // },
            // defaultBuilder: (context, date, _) {
            //   final matchingReport = model.monthlyReport.firstWhere(
            //     (report) {
            //       final reportDate = DateTime.parse(report.date);
            //       return DateTime(
            //               reportDate.year, reportDate.month, reportDate.day) ==
            //           date;
            //     },
            //     orElse: () => AttendanceReportData(
            //       date: date.toString(),
            //       checkInTime: '-',
            //       checkOutTime: '-',
            //       lunchIn: '-',
            //       lunchOut: '-',
            //       lunchDuration: '-',
            //       weekend: '-',
            //       workingHours: '-',
            //       totalWorkingHours: '-',
            //     ),
            //   );

            //   return Container(
            //     alignment: Alignment.center,
            //     color: date.isBefore(today)
            //         ? matchingReport.weekend.isNotEmpty
            //             ? const Color.fromARGB(255, 139, 213, 245)
            //             : matchingReport.holiday != null
            //                 ? Colors.amber.shade100
            //                 : matchingReport.checkInTime == "00:00" &&
            //                         matchingReport.checkOutTime == "00:00"
            //                     ? Colors.white70
            //                     : _getCardColor(
            //                         matchingReport.totalWorkingHours)
            //         : null,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(date.day.toString()),
            //         if (date.isBefore(today)) ...[
            //           Text(
            //             'In: ${matchingReport.checkInTime}',
            //             style: const TextStyle(fontSize: 10),
            //           ),
            //           Text(
            //             'Out: ${matchingReport.checkOutTime}',
            //             style: const TextStyle(fontSize: 10),
            //           ),
            //         ]
            //       ],
            //     ),
            //   );
            // },
