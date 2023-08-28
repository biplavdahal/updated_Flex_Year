

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.data.freezed.dart';
part 'notification.data.g.dart';

@freezed
class NotificationData with _$NotificationData {
  const factory NotificationData({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'details') required String detailsm,
    @JsonKey(name: 'date') required String date,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}
