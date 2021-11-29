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
import 'package:flex_year_tablet/ui/app_access/app_access.model.dart';
import 'package:flex_year_tablet/ui/attendance_report/attandance_report.model.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/ui/attendance_summary/attendance_summary.model.dart';
import 'package:flex_year_tablet/ui/write_leave_request/write_leave_request.model.dart';
import 'package:flex_year_tablet/ui/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/leave_requests/leave_requests.model.dart';
import 'package:flex_year_tablet/ui/login/login.model.dart';
import 'package:flex_year_tablet/ui/profile/profile.model.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.model.dart';

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

  // Unkillable models
  locator.registerLazySingleton(() => LeaveRequestModel());
}
