import 'package:flex_year_tablet/data_models/staff.data.dart';

abstract class UserService {
  /// Update user/staff profile
  Future<void> updateProfile(StaffData data);

  /// Change password
  Future<void> changePassword(String password);
}
