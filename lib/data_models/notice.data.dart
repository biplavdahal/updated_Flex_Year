// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'notice.data.freezed.dart';
part 'notice.data.g.dart';

@freezed
class NoticeData with _$NoticeData {
  const factory NoticeData({
    @JsonKey(name: "att_correction_pending") String? attendencePending,
    @JsonKey(name: "att_correction_approve") String? attendenceApprove,
    @JsonKey(name: "att_correction_decline") String? attendenceDecline,
    @JsonKey(name: "approve_leave") String? approveLeave,
    @JsonKey(name: "decline_leave") String? declineLeave,
    @JsonKey(name: "pending_leave") String? pendingLeave,
  }) = _NoticeData;

  factory NoticeData.fromJson(Map<String, dynamic> json) =>
      _$NoticeDataFromJson(json);
}
