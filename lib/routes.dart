import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/_test/test.view.dart';
import 'package:flex_year_tablet/ui/frontdesk/attendance/attendance.view.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.view.dart';
import 'package:flex_year_tablet/ui/personal/add_attendance/add_attendance.view.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/app_access_client_code/app_access_client_code.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction_review/attendance_correction_review.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attendance_report.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.view.dart';
import 'package:flex_year_tablet/ui/personal/change_password/change_password_view.dart';
import 'package:flex_year_tablet/ui/personal/chat_contacts/chat_contacts.view.dart';
import 'package:flex_year_tablet/ui/personal/chats/chats.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/flex_calander/calander.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/presentStaff/presentstaff.view.dart';
import 'package:flex_year_tablet/ui/personal/date_converter/date_converter.view.dart';
import 'package:flex_year_tablet/ui/personal/edit_profile/edit_profile.view.dart';
import 'package:flex_year_tablet/ui/personal/forget%20password/forget_password_view.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/leave_request_received.view.dart';
import 'package:flex_year_tablet/ui/personal/notice/notice.view.dart';
import 'package:flex_year_tablet/ui/personal/notifications/notification.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flex_year_tablet/ui/personal/performance/performance_view.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.view.dart';
import 'package:flex_year_tablet/ui/personal/resign/clearance/clearance.view.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_view.dart';
import 'package:flex_year_tablet/ui/personal/resign/write_exit_interview/exit_interview.dart';
import 'package:flex_year_tablet/ui/personal/resign/write_exit_interview/survey.dart';
import 'package:flex_year_tablet/ui/personal/resign/write_resigh_request/write_resign_request.view.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory.view.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory_detail/staff_directory_detail.view.dart';
import 'package:flex_year_tablet/ui/personal/staff_leave/staff_leave.view.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.view.dart';
import 'package:flex_year_tablet/ui/personal/upcoming_birthday/upcoming_birthday.view.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.view.dart';
import 'package:flutter/material.dart';

Map<String, Widget> routesAndViews(RouteSettings settings) => {
      ForgetPasswordFragment.tag: const ForgetPasswordFragment(),
      ChangePasswordView.tag: const ChangePasswordView(),
      TestView.tag: const TestView(),
      EditProfileView.tag: const EditProfileView(),
      LoginView.tag: const LoginView(),
      AppAccessView.tag: const AppAccessView(),
      AppAccessClientCodeView.tag: const AppAccessClientCodeView(),
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
      EnterPinView.tag: const EnterPinView(),
      AttendanceView.tag: const AttendanceView(),
      ChatContactsView.tag: const ChatContactsView(),
      ChatsView.tag: ChatsView(settings.arguments as Arguments?),
      PayrollView.tag: PayrollView(settings.arguments as Arguments?),
      PayrollFilterView.tag:
          PayrollFilterView(settings.arguments as Arguments?),
      NoticeView.tag: const NoticeView(),
      DateConverterView.tag: const DateConverterView(),
      PerformanceView.tag: PerformanceView(
        arguments: settings.arguments as Arguments?,
      ),
      CalanderView.tag: const CalanderView(),
      PresentStaffView.tag: const PresentStaffView(),
      AllStaffBirthdayView.tag: const AllStaffBirthdayView(),
      StaffLeaveView.tag: const StaffLeaveView(),
      AllNotificationView.tag: const AllNotificationView(),
      StaffDirectoryView.tag: const StaffDirectoryView(),
      StaffDirectoryDetailView.tag:
          StaffDirectoryDetailView(settings.arguments as Arguments?),
      ResignView.tag: ResignView(settings.arguments as Arguments?),
      WriteResignRequestView.tag:
          WriteResignRequestView(settings.arguments as Arguments?),
      ClearanceView.tag: const ClearanceView(),
      ExitInterview.tag: const ExitInterview(),
      SurveyView.tag: const SurveyView()
    };
