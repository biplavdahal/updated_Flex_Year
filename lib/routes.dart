import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/attendance_report/attendance_report.view.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.view.dart';
import 'package:flex_year_tablet/ui/write_leave_request/write_leave_request.view.dart';
import 'package:flex_year_tablet/ui/dashboard/dashboard.view.dart';
import 'package:flex_year_tablet/ui/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/login/login.view.dart';
import 'package:flex_year_tablet/ui/profile/profile.view.dart';
import 'package:flutter/material.dart';

Map<String, Widget> routesAndViews(RouteSettings settings) => {
      LoginView.tag: const LoginView(),
      AppAccessView.tag: const AppAccessView(),
      DashboardView.tag: const DashboardView(),
      ProfileView.tag: const ProfileView(),
      LeaveRequestView.tag: const LeaveRequestView(),
      WriteLeaveRequestView.tag:
          WriteLeaveRequestView(settings.arguments as Arguments?),
      AttendanceReportView.tag: const AttendanceReportView(),
      AttendanceReportFilterView.tag:
          AttendanceReportFilterView(settings.arguments as Arguments?),
    };
