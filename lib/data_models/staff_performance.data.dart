

import 'package:flex_year_tablet/data_models/staff_performance_type.data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_performance.data.freezed.dart';
part 'staff_performance.data.g.dart';

@freezed
class StaffPerformanceData with _$StaffPerformanceData {
  const factory StaffPerformanceData({
    @JsonKey(name: 'department') String? department,
    @JsonKey(name: 'type') required StaffPerformanceTypeData type,
  }) = _StaffPerformanceData;

  factory StaffPerformanceData.fromJson(Map<String, dynamic> json) =>
      _$StaffPerformanceDataFromJson(json);
}
