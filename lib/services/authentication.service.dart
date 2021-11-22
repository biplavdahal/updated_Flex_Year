import 'package:flex_year_tablet/data_models/user.data.dart';

abstract class AuthenticationService {
  UserData? get user;

  /// Checks if users is loggedin or not
  Future<bool> isLoggedIn();

  /// Authenticate user by username and password
  Future<void> authByUsername({
    required String username,
    required String password,
  });

  /// Authenticate user by login pin
  Future<void> authByPin({
    required String pin,
  });

  /// Get saved username
  Future<String?> getSavedUsername();

  /// Save username on remember me
  Future<void> saveUsername(String username);

  /// Logout user and clear all data
  Future<void> logout();
}
