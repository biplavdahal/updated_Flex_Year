import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/data_models/attendance_correction_review.data.dart';
import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_one_day_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report_summary.data.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';
import 'package:flex_year_tablet/data_models/attendance_weekly_report.data.dart';

import '../data_models/present_staff.data.dart';

abstract class AttendanceService {
  /// Get attendance status for dashboard
  Future<AttendanceStatusData> getAttendanceStatus({
    String? clientId,
  });

  /// Get attendance forgotten status
  Future<AttendanceForgotData?> getAttendanceForgot();

  /// Post attendance status
  Future<AttendanceStatusData> postAttendanceStatus(
      {required String time,
      String? clientId,
      required String status,
      String checkInMessage,
       String checkOutMessage,});

  /// Get monthly report
  ///
  /// Goto [AttendanceReportFilterModel] to see what [data] holds
  Future<List<AttendanceReportData>> getMonthlyReport({
    required Map<String, dynamic> data,
  });

  Future<List<AttendanceReportSummaryData>> getMonthlySummary({
    required Map<String, dynamic> data,
  });

  /// Get attendance summary
  Future<List<AttendanceSummaryData>> getAttendanceSummary({
    required String date,
    String? clientId,
    String? staffId,
  });

  // Get weekly report
  Future<List<AttendanceWeeklyReportData>> getWeeklyReport({
    required Map<String, dynamic> data,
  });

  /// Get list of attendance corrections
  Future<List<AttendanceCorrectionData>> getAttendanceCorrections(
      {required String dateTime});

  /// Post forget checkout review
  Future<void> postForgetCheckoutReview({
    required String attendanceId,
    required String dateTime,
    String? message,
  });

  ///post Today's attendance request review
  Future<void> postTodayAttendanceRequestReview(
      {required String reqDate,
      required String dateTime,
      String? message,
      required String attendanceId});

  /// Remove attendance correction
  Future<void> removeAttendanceCorrection(String attendanceId);

  /// Post attendance correction
  Future<void> addAttendanceCorrection({
    required String attendanceId,
    required String inDateTime,
    required String outDateTime,
    String? message,
  });

  /// Edit attendance correction
  Future<void> editAttendanceCorrection({
    required String attendanceId,
    required String inDateTime,
    required String outDateTime,
    String? message,
  });

  /// Get one day report
  Future<List<AttendanceOneDayReportData>> getOneDayReport({
    required Map<String, dynamic> data,
  });

  /// Getter for boolean value to indicate if there is more data to be loaded
  bool get hasMoreData;

  /// Get all attendance correction reviews
  Future<List<AttendanceCorrectionReviewData>> getAttendanceCorrectionReviews(
      {required int limit, required int id});

  /// Approve or decline attendance review
  Future<void> actionOnAttendanceCorrectionReview({
    required String attendanceId,
    required String status, // 0 pending, 1 approve, 2 decline
  });

  /// Add attendance to staff
  Future<void> addAttendanceToStaff({
    String checkInDateTime = '',
    String checkOutDateTime = '',
    String lunchInDateTime = '',
    String lunchOutDateTime = '',
    required List<String> userIds,
    String? clientId,
  });

  // Present staff attandance
  //Getter for all staffs
  List<PresentStaffModelData> get presentStaff;

  //set for all staff
  set presentStaff(List<PresentStaffModelData> value);

  //fetch all present staff
  Future<List<PresentStaffModelData>> getPresentstaffs();
}
