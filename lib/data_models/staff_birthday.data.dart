// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_birthday.data.freezed.dart';
part 'staff_birthday.data.g.dart';

@freezed
class StaffBirthdayData with _$StaffBirthdayData {
  const factory StaffBirthdayData({
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'dob') String? dob,
    @JsonKey(name: 'gender') String? gender,
  }) = _StaffBirthdayData;

  factory StaffBirthdayData.fromJson(Map<String, dynamic> json) =>
      _$StaffBirthdayDataFromJson(json);
}
