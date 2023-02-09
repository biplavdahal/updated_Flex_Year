// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_report_detail.data.freezed.dart';
part 'attendance_report_detail.data.g.dart';

@freezed
class AttendanceReportDetailData with _$AttendanceReportDetailData {
  const factory AttendanceReportDetailData({
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'total') String? Total,
    @JsonKey(name: 'leavetot') String? totalLeaveDays,
    @JsonKey(name: 'present') String? totalPresentDays,
    @JsonKey(name: 'offday') String? totalOffDays,
    @JsonKey(name: 'totaldays') String? totalDays,
    @JsonKey(name: 'absent') String? totalAbsentDays,
    @JsonKey(name: 'workinghr') String? totalWorkingHours,
    @JsonKey(name: 'workingdays') String? totalWorkingDays,
  }) = _AttendanceReportDetailData;

  factory AttendanceReportDetailData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportDetailDataFromJson(json);
}
