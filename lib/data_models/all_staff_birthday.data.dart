

import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_staff_birthday.data.freezed.dart';
part 'all_staff_birthday.data.g.dart';

@freezed
class AllStaffBirthdayData with _$AllStaffBirthdayData {
  const factory AllStaffBirthdayData({
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'staff_photo')  String? staffPhoto,
    @JsonKey(name: 'remaining_days') String? remainingDays,
    @JsonKey(name: 'dob') String? dob,
  }) = _AllStaffBirthdayData;

  factory AllStaffBirthdayData.fromJson(Map<String, dynamic> json) =>
      _$AllStaffBirthdayDataFromJson(json);
}
