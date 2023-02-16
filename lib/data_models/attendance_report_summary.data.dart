// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_report_summary.data.freezed.dart';
part 'attendance_report_summary.data.g.dart';

@freezed
class AttendanceReportSummary with _$AttendanceReportSummary {
  const factory AttendanceReportSummary({
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'total') required String Total,
    @JsonKey(name: 'leavetot')  required String totalLeaveDays,
    @JsonKey(name: 'present') required String totalPresentDays,
    @JsonKey(name: 'offday') required String totalOffDays,
    @JsonKey(name: 'totaldays') required String totalDays,
    @JsonKey(name: 'absent') required String totalAbsentDays,
    @JsonKey(name: 'workinghr') required String totalWorkingHours,
    @JsonKey(name: 'workingdays') required String totalWorkingDays,
  }) = _AttendanceReportSummary;

  factory AttendanceReportSummary.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportSummaryFromJson(json);
}
