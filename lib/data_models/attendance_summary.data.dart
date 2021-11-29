// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_summary.data.freezed.dart';
part 'attendance_summary.data.g.dart';

@freezed
class AttendanceSummaryData with _$AttendanceSummaryData {
  const factory AttendanceSummaryData({
    @JsonKey(name: 'attendance_id') required String attendanceId,
    @JsonKey(name: 'status') required String statusIn,
    @JsonKey(name: 'status_out') required String statusOut,
    @JsonKey(name: 'checkin_datetime') required String chekinDatetime,
    @JsonKey(name: 'checkout_datetime') required String checkoutDatetime,
    @JsonKey(name: 'tot_work') required String totalWorkedHour,
  }) = _AttendanceSummaryData;

  factory AttendanceSummaryData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryDataFromJson(json);
}
