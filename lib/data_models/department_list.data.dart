

import 'package:freezed_annotation/freezed_annotation.dart';

part 'department_list.data.freezed.dart';
part 'department_list.data.g.dart';

@freezed
class DepartmentListdata with _$DepartmentListdata {
  const factory DepartmentListdata({
    @JsonKey(name: 'department_id') required int departmentId,
    @JsonKey(name: 'department_name')  String? departmentName,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'icon') String? icon,
  }) = _DepartmentListdata;

  factory DepartmentListdata.fromJson(Map<String, dynamic> json) =>
      _$DepartmentListdataFromJson(json);
}
