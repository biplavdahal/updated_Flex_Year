// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_correction.data.freezed.dart';
part 'attendance_correction.data.g.dart';

@freezed
class AttendanceCorrectionData with _$AttendanceCorrectionData {
  const factory AttendanceCorrectionData({
    @JsonKey(name: 'attendance_id') required String attendanceId,
    @JsonKey(name: 'checkin_datetime') String? checkinDatetime,
    @JsonKey(name: 'checkout_datetime') String? checkoutDatetime,
    @JsonKey(name: 'checkin_datetime_request') String? checkinDatetimeRequest,
    @JsonKey(name: 'checkout_datetime_request') String? checkoutDatetimeRequest,
    @JsonKey(name: 'correction_status') required String correctionStatus,
    @JsonKey(name: 'checkin_status') String? checkInStatus,
        @JsonKey(name: 'checkout_status') String? checkOutStatus,
  }) = _AttendanceCorrectionData;

  factory AttendanceCorrectionData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCorrectionDataFromJson(json);
}
