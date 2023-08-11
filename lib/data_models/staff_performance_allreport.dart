
// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_performance_allreport.freezed.dart';
part 'staff_performance_allreport.g.dart';


@freezed
class StaffPerformanceAllReportData with _$StaffPerformanceAllReportData {
  const factory StaffPerformanceAllReportData({
    @JsonKey(name: 'year') String? year ,
    @JsonKey(name: 'month') String? month,
    @JsonKey(name: 'remarks') String? remarks,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'update_by') String? updateBy,
    @JsonKey(name: 'job_know') String? jobKnow,
    @JsonKey(name: 'job_know_commrnt') String? jobknowCommrnt,
    @JsonKey(name: 'quality') String? quality,
    @JsonKey(name: 'quality_comment') String? qualityComment,
    @JsonKey(name: 'punctuality') String? punctuality,
    @JsonKey(name: 'punctuality_comment') String? punctualityComment,
    @JsonKey(name: 'productivity') String? productivity,
    @JsonKey(name: 'productivity_comment') String? productivityComment,
    @JsonKey(name: 'communication') String? communication,
    @JsonKey(name: 'communication_comment') String? communicationComment,
    @JsonKey(name: 'dependability') String? dependability,
    @JsonKey(name: 'dependability_comment') String? dependabilityComment,
    @JsonKey(name: 'additional_comment') String? additionalComment,
    @JsonKey(name: 'goal_comment') String? goalComment,
    @JsonKey(name: 's_name') String? signatureName,
    @JsonKey(name: 's_date') String? signatureDate,
    @JsonKey(name: 'from') String? from,
    @JsonKey(name: 'to_date') String? toDate
  
  }) = _StaffPerformanceAllReportData;
  

  factory StaffPerformanceAllReportData.fromJson(Map<String, dynamic> json) =>
  _$StaffPerformanceAllReportDataFromJson(json);
}
