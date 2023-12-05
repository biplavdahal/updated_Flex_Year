// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.data.freezed.dart';
part 'chat_message.data.g.dart';

/*
{
      "message_id": 60,
      "message_content": "Hellooooii",
      "posted_datetime": "2021-12-28 11:33:47",
      "sender_id": 1894,
      "receiver_id": 1898,
      "review_status": 0,
      "company_id": 151,
      "msg_group_id": null,
      "file": null,
      "type": "chat"
    }
    */

@freezed
class ChatMessageData with _$ChatMessageData {
  const factory ChatMessageData({
    @JsonKey(name: 'message_id') int? messageId,
    @JsonKey(name: 'message_content') String? messageContent,
    @JsonKey(name: 'posted_datetime') String? postedDatetime,
    @JsonKey(name: 'sender_id') int? senderId,
    @JsonKey(name: 'review_status') int? reviewStatus,
    @JsonKey(name: 'company_id') int? companyId,
    @JsonKey(name: 'msg_group_id') int? msgGroupId,
    @JsonKey(name: 'file') String? file,
    @JsonKey(name: 'type') String? type,
  }) = _ChatMessageData;

  factory ChatMessageData.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDataFromJson(json);
}
