import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';

abstract class AttendanceService {
  /// Get attendance status for dashboard
  Future<AttendanceStatusData> getAttendanceStatus({
    String? clientId,
  });

  /// Get attendance forgotten status
  Future<AttendanceForgotData?> getAttendanceForgot();

  /// Post attendance status
  Future<AttendanceStatusData> postAttendanceStatus({
    required String time,
    String? clientId,
    required String status,
  });

  /// Get monthly report
  ///
  /// Goto [AttendanceReportFilterModel] to see what [data] holds
  Future<List<AttendanceReportData>> getMonthlyReport({
    required Map<String, dynamic> data,
  });

  /// Get attendance summary
  Future<List<AttendanceSummaryData>> getAttendanceSummary({
    required String date,
    String? clientId,
  });
}
