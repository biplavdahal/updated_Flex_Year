import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_resign.data.freezed.dart';
part 'user_resign.data.g.dart';

@freezed
class ResignData with _$ResignData {
  const factory ResignData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'letter') String? letter,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'feedback') String? feedBack,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'status') String? status,
  }) = _ResignData;

  factory ResignData.fromJson(Map<String, dynamic> json) =>
      _$ResignDataFromJson(json);
}
