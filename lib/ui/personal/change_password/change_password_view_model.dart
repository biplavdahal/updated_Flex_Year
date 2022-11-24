import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/user_service.dart';
import 'package:flutter/material.dart';

class ChangePasswordViewModel extends ViewModel
    with DialogMixin, SnackbarMixin {
  //Services
  final UserService _userService = locator<UserService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

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

  //Actions
  Future<void> onSetNewPasswordPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        dialog.showDialog(DialogRequest(
            type: DialogType.progress, title: "Change in progres ..."));
        await _userService.changePassword(_newPasswordController.text);

        dialog.hideDialog();
        snackbar.displaySnackbar(SnackbarRequest.of(
          message: "Password changed successfuly!",
          type: ESnackbarType.success,
        ));
        goBack();
      } on DioError catch (e) {
        dialog.hideDialog();
        if(_oldPasswordController.text != _authenticationService.user ){}

        snackbar.displaySnackbar(
          SnackbarRequest.of(
            message: e.toString(),
          ),
        );
      }
    }
  }
}
