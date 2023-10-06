// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff.data.freezed.dart';
part 'staff.data.g.dart';

@freezed
class StaffData with _$StaffData {
  const factory StaffData({
    @JsonKey(name: 'staff_id') int?staffId,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'middle_name')  String? middleName,
    @JsonKey(name: 'last_name')  String? lastName,
    @JsonKey(name: 'staff_photo') String? staffPhoto,
    @JsonKey(name: 'mobile') String ? mobile,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'email_address')  String? email,
    @JsonKey(name: 'gender')  String? gender,
    @JsonKey(name: 'marital_status') String? maritalStatus,
    @JsonKey(name: 'hire_date') String? hireDate,
    @JsonKey(name: 'emp_id')String? empId,
    @JsonKey(name: 'dob') String? dob,
    @JsonKey(name: 'remaining_leave_days') String? remainingLeave,
    @JsonKey(name: 'sick_leave') String? sickLeave,
    @JsonKey(name: 'citizenship_no') String? citizenshipNo,
    @JsonKey(name: 'expiry_date') String? expiryDate,
    @JsonKey(name: 'employee_type') String? employeeType,
    @JsonKey(name: 'salary_period') String? salaryPeriod,
    // @JsonKey(name: 'normal_salary_rate') String? normalSalaryRate,
    // @JsonKey(name: 'overtime_salary_rate') String? overtimeSalaryRate,
    @JsonKey(name: 'payment_type') String? paymentType,
    @JsonKey(name: 'checkinRestrictiontime') String? checkinRestrictionTime,
    @JsonKey(name: 'remarks') String? remarks,
  }) = _StaffData;

  factory StaffData.fromJson(Map<String, dynamic> json) =>
      _$StaffDataFromJson(json);
}
