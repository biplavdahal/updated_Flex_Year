// ignore_for_file: invalid_annotation_target
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_correction.data.freezed.dart';
part 'attendance_correction.data.g.dart';

@freezed
class AttendanceCorrectionData with _$AttendanceCorrectionData {
  const factory AttendanceCorrectionData({
 
    @JsonKey(name: 'checkin_datetime') String? checkinDatetime,
    @JsonKey(name: 'checkout_datetime') String? checkoutDatetime,
    @JsonKey(name: 'status') String? Status,
    @JsonKey(name: 'status_out') String? statusOut,

 
  }) = _AttendanceCorrectionData;

  factory AttendanceCorrectionData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCorrectionDataFromJson(json);
}
