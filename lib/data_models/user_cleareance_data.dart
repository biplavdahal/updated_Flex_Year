import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_cleareance_data.freezed.dart';
part 'user_cleareance_data.g.dart';

@freezed
class Clearancedata with _$Clearancedata {
  const factory Clearancedata(
      {@JsonKey(name: 'status') String? status,
      @JsonKey(name: 'date') String? date,
      @JsonKey(name: 'clearance_name') String? clearanceName,
      @JsonKey(name: 'types') String? types}) = _Clearancedata;

  factory Clearancedata.fromJson(Map<String, dynamic> json) =>
      _$ClearancedataFromJson(json);
}
