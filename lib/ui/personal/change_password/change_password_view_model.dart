import 'dart:math';

import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/constants/prefs.constants.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/user_service.dart';
import 'package:flutter/material.dart';

import '../../../data_models/error_data.dart';
import '../dashboard/dashboard.model.dart';
import '../login/login.view.dart';

class ChangePasswordViewModel extends ViewModel
    with DialogMixin, SnackbarMixin {
  //Services
  final UserService _userService = locator<UserService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  //UI components
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController => _newPasswordController;
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  final TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController get oldPasswordController => _oldPasswordController;

  String get oldPassword => oldPasswordController.text;

  String get verifyPassword => confirmPasswordController.text;

  String get newPassword => newPasswordController.text;

  //Actions
  Future<void> onSetNewPasswordPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        dialog.showDialog(DialogRequest(
            type: DialogType.progress, title: "Change in progres ..."));
        await _userService.changePassword(
          oldPassword: _oldPasswordController.text,
          verifyPassword: _confirmPasswordController.text,
          newPassword: _newPasswordController.text,
        );

        dialog.hideDialog();
        snackbar.displaySnackbar(SnackbarRequest.of(
            message: "Password changed Successfully",
            type: ESnackbarType.success));

        goBack();
      } catch (e) {
        dialog.hideDialog();
        snackbar.displaySnackbar(SnackbarRequest.of(
            message: "Old Password Invalid", type: ESnackbarType.error));
            
      }
    }
  }

  void onCancelPressed() {
    goBack();
  }
}
