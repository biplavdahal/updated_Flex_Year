import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.service.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.service.impl.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/services/implementations/app_access.service.impl.dart';
import 'package:flex_year_tablet/services/implementations/attendance.service.impl.dart';
import 'package:flex_year_tablet/services/implementations/authentication.service.impl.dart';
import 'package:flex_year_tablet/services/implementations/company.service.impl.dart';
import 'package:flex_year_tablet/services/implementations/leave.service.impl.dart';
import 'package:flex_year_tablet/services/leave.service.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.model.dart';
import 'package:flex_year_tablet/ui/personal/add_attendance/add_attendance.model.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.model.dart';
import 'package:flex_year_tablet/ui/app_access_client_code/app_access_client_code.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction_review/attendance_correction_review.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attandance_report.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.model.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.model.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/leave_request_received.model.dart';
import 'package:flex_year_tablet/ui/personal/login/login.model.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.model.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.model.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.model.dart';

Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceServiceImplementation());
  locator.registerLazySingleton<ApiService>(() => ApiServiceImplementation());
  locator.registerLazySingleton<NavigationService>(
      () => NavigationServiceImplementation());
  locator.registerLazySingleton<SnackbarService>(
      () => SnackbarServiceImplementation());
  locator.registerLazySingleton<AppAccessService>(
      () => AppAccessServiceImplementation());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceImpl());
  locator.registerLazySingleton<DialogService>(
      () => DialogServiceImplementation());
  locator
      .registerLazySingleton<AttendanceService>(() => AttendanceServiceImpl());
  locator.registerLazySingleton<CompanyService>(() => CompanyServiceImpl());
  locator.registerLazySingleton<LeaveService>(() => LeaveServiceImpl());

  // Killable models
  locator.registerFactory(() => StartUpModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => AppAccessModel());
  locator.registerFactory(() => DashboardModel());
  locator.registerFactory(() => ProfileModel());
  locator.registerFactory(() => WriteLeaveRequestModel());
  locator.registerFactory(() => AttendanceReportModel());
  locator.registerFactory(() => AttendanceReportFilterModel());
  locator.registerFactory(() => AttendanceSummaryModel());
  locator.registerFactory(() => HolidaysModel());
  locator.registerFactory(() => AttendanceCorrectionModel());
  locator.registerFactory(() => RequestReviewModel());
  locator.registerFactory(() => StaffsModel());
  locator.registerFactory(() => AttendanceCorrectionReviewModel());
  locator.registerFactory(() => LeaveRequestReceivedModel());
  locator.registerFactory(() => AddAttendanceModel());
  locator.registerFactory(() => AppAccessClientCodeModel());
  locator.registerFactory(() => EnterPinModel());

  // Unkillable models
  locator.registerLazySingleton(() => LeaveRequestModel());
}
