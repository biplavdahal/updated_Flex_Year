import 'package:flex_year_tablet/data_models/department_detail_list.data.dart';
import 'package:flex_year_tablet/data_models/department_list.data.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';

abstract class UserService {
  /// Update user/staff profile
  Future<void> updateProfile(StaffData data);

  /// Change password
  Future<void> changePassword({
    required String oldPassword,
    required String verifyPassword,
    required String newPassword,
  });

  //For Staff directory
  List<DepartmentDetailListdata> get details;

  set details(List<DepartmentDetailListdata> value);

  bool get hasMoreData;

  Future<List<DepartmentListdata>> getDepartmentList();

  Future<List<DepartmentDetailListdata>> getDepartmentDetailList({
    required Map<String, dynamic> data, required id
  });
}
