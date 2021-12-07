import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/add_attendance/add_attendance.view.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/attendance_correction/attendance_correction.view.dart';
import 'package:flex_year_tablet/ui/attendance_correction_review/attendance_correction_review.view.dart';
import 'package:flex_year_tablet/ui/attendance_report/attendance_report.view.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.view.dart';
import 'package:flex_year_tablet/ui/attendance_summary/attendance_summary.view.dart';
import 'package:flex_year_tablet/ui/holidays/holidays.view.dart';
import 'package:flex_year_tablet/ui/leave_requests_received/leave_request_received.view.dart';
import 'package:flex_year_tablet/ui/request_review/request_review.view.dart';
import 'package:flex_year_tablet/ui/staffs/staffs.view.dart';
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
      HolidaysView.tag: const HolidaysView(),
      AttendanceCorrectionView.tag: const AttendanceCorrectionView(),
      LeaveRequestView.tag: const LeaveRequestView(),
      WriteLeaveRequestView.tag:
          WriteLeaveRequestView(settings.arguments as Arguments?),
      RequestReviewView.tag:
          RequestReviewView(settings.arguments as Arguments?),
      AttendanceReportView.tag:
          AttendanceReportView(settings.arguments as Arguments?),
      AttendanceReportFilterView.tag:
          AttendanceReportFilterView(settings.arguments as Arguments?),
      AttendanceSummaryView.tag:
          AttendanceSummaryView(settings.arguments as Arguments?),
      StaffsView.tag: StaffsView(settings.arguments as Arguments?),
      AttendanceCorrectionReviewView.tag:
          const AttendanceCorrectionReviewView(),
      LeaveRequestReceivedView.tag: const LeaveRequestReceivedView(),
      AddAttendanceView.tag: const AddAttendanceView(),
    };
