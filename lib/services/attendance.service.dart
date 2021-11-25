import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';

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

  /// Get attendance report by date range and client ID
  /// 

}
