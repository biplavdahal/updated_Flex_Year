// ignore_for_file: invalid_annotation_target

import 'package:flex_year_tablet/data_models/staff_performance_allreport.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_performance.data.freezed.dart';
part 'staff_performance.data.g.dart';

@freezed
class StaffPerformanceData with _$StaffPerformanceData {
  const factory StaffPerformanceData({
    // @JsonKey(name: 'type') required StaffPerformanceTypeData type,
    @JsonKey(name: 'model') required StaffPerformanceAllReportData allReport,
  }) = _StaffPerformanceData;

  factory StaffPerformanceData.fromJson(Map<String, dynamic> json) =>
      _$StaffPerformanceDataFromJson(json);
}
