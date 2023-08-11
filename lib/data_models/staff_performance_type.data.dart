
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_performance_type.data.freezed.dart';
part 'staff_performance_type.data.g.dart';

@freezed
class StaffPerformanceTypeData with _$StaffPerformanceTypeData {
  const factory StaffPerformanceTypeData({
    @JsonKey(name: 'employee_type') String? employeeType,
    @JsonKey(name: 'description') String? description,
  }) = _StaffPerformanceTypeData;

    factory StaffPerformanceTypeData.fromJson(Map<String, dynamic> json) =>
      _$StaffPerformanceTypeDataFromJson(json);
}
