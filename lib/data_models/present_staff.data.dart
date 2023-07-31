
import 'package:freezed_annotation/freezed_annotation.dart';

part 'present_staff.data.freezed.dart';
part 'present_staff.data.g.dart';

@freezed
class PresentStaffModelData with _$PresentStaffModelData {
  const factory PresentStaffModelData({
    @JsonKey(name: 'staff_name') required String staffName,
    @JsonKey(name: 'checkintime') required String checkInTime,
    @JsonKey(name: 'checkouttime') required String checkOutTime,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'hours') required String hours,
  }) = _PresentStaffModelData;

  factory PresentStaffModelData.fromJson(Map<String, dynamic> json) =>
      _$PresentStaffModelDataFromJson(json);
}
