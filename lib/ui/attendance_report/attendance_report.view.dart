import 'package:bestfriend/ui/view.dart';
import 'package:flutter/material.dart';

class AttendanceReportView extends StatelessWidget {
  static String tag = 'attendance-report-view';

  const AttendanceReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View(builder: (ctx, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Attendance Report'),
        ),
        body: const Center(
          child: Text('Attendance Report'),
        ),
      );
    });
  }
}
