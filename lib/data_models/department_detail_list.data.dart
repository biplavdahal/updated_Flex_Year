

import 'package:freezed_annotation/freezed_annotation.dart';

part 'department_detail_list.data.freezed.dart';
part 'department_detail_list.data.g.dart';


@freezed
class DepartmentDetailListdata with _$DepartmentDetailListdata {
  const factory DepartmentDetailListdata({
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'staff_photo') String? staffPhoto,
    @JsonKey(name: 'mobile') String? mobile,
    @JsonKey(name: 'email_address') String? emailAddress,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'marital_status') String? maritalStatus,

  })= _DepartmentDetailListdata;

  factory DepartmentDetailListdata.fromJson(Map<String, dynamic> json) =>
  _$DepartmentDetailListdataFromJson(json);
  
}