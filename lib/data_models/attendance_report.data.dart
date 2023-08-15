// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_report.data.freezed.dart';
part 'attendance_report.data.g.dart';

@freezed
class AttendanceReportData with _$AttendanceReportData {
  const factory AttendanceReportData(
      {@JsonKey(name: 'date') required String date,
      @JsonKey(name: 'in') required String checkInTime,
      @JsonKey(name: 'out') required String checkOutTime,
      @JsonKey(name: 'holiday') String? holiday,
      @JsonKey(name: 'weekend') required String weekend,
      @JsonKey(name: 'leave_type') String? leaveType,
      @JsonKey(name: 'leave_time') String? leaveTime,
      @JsonKey(name: 'lunch_in') required String lunchIn,
      @JsonKey(name: 'lunch_out') required String lunchOut,
      @JsonKey(name: 'total_lunch') required String lunchDuration,
      @JsonKey(name: 'attendance') required String workingHours,
      @JsonKey(name: 'grand_total') required String totalWorkingHours,
      @JsonKey(name: 'nepali_date') required String nepaliDate,
      @JsonKey(name: 'title') required String title}) = _AttendanceReportData;

  factory AttendanceReportData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportDataFromJson(json);

  static AttendanceReportData empty() {
    return const AttendanceReportData(
        nepaliDate: '',
        holiday: '',
        weekend: "",
        checkInTime: "",
        checkOutTime: "",
        totalWorkingHours: "",
        date: '',
        lunchDuration: '',
        lunchIn: '',
        lunchOut: '',
        workingHours: '',
        title: '');
  }
}
