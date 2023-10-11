// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_request.data.freezed.dart';
part 'leave_request.data.g.dart';

@freezed
class LeaveRequestData with _$LeaveRequestData {
  const factory LeaveRequestData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'staff_id') String? staffId,
    @JsonKey(name: 'date_to')  String? dateTo,
    @JsonKey(name: 'date_from') String? dateFrom,
    @JsonKey(name: 'description') String? reason,
    @JsonKey(name: 'is_approved')  String? status,
    @JsonKey(name: 'no_of_days') String? numberOfDays,
    @JsonKey(name: 'hour') String? totalHours,
    @JsonKey(name: 'leave_type')  String? leaveType,
    @JsonKey(name: 'title')  String? title,
    @JsonKey(name: 'from_time') String? fromTime,
    @JsonKey(name: 'to_time') String? toTime,
    @JsonKey(name: 'requested_date') String? requestedDate,
    @JsonKey(name: 'staffname')  String? staffName,
    @JsonKey(name: 'checked_by')  String? checkedBy,
    @JsonKey(name: 'checked_by_name') String? checkedByName,
  }) = _LeaveRequestData;

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestDataFromJson(json);
}
