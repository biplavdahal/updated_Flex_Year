import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_exit_survey.data.freezed.dart';
part 'user_exit_survey.data.g.dart';

@freezed
class ExitSurveyData with _$ExitSurveyData {
  const factory ExitSurveyData(
      {@JsonKey(name: 'id') required int questionId,
      @JsonKey(name: 'question') String? question,
      @JsonKey(name: 'option_1') String? optionOne,
      @JsonKey(name: 'option_2') String? optionTwo,
      @JsonKey(name: 'option_3') String? optionThree,
      @JsonKey(name: 'option_4') String? optionFour,
      @JsonKey(name: 'date') String? date}) = _ExitSurveyData;

  factory ExitSurveyData.fromJson(Map<String, dynamic> json) =>
      _$ExitSurveyDataFromJson(json);
}
