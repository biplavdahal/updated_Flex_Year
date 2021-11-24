import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/ui/dashboard/dashboard.view.dart';
import 'package:flutter/material.dart';

class LoginModel extends ViewModel with DialogMixin, SnackbarMixin {
  // Services
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  // UI components
  final GlobalKey<FormState> _loginWithPinFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginWithPinFormKey => _loginWithPinFormKey;
  final GlobalKey<FormState> _loginWithUsernamePasswordFormKey =
      GlobalKey<FormState>();
  GlobalKey<FormState> get loginWithUsernamePasswordFormKey =>
      _loginWithUsernamePasswordFormKey;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get pinController => _pinController;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  set rememberMe(bool value) {
    _rememberMe = value;
    setIdle();
  }

  bool _showLoginWithPin = false;
  bool get showLoginWithPin => _showLoginWithPin;
  set showLoginWithPin(bool value) {
    _showLoginWithPin = value;
    setIdle();
  }

  // Actions
  Future<void> init() async {
    _usernameController.text =
        await _authenticationService.getSavedUsername() ?? "";
    setIdle();
  }

  Future<void> login() async {
    try {
      if (_showLoginWithPin && loginWithPinFormKey.currentState!.validate()) {
        dialog.showDialog(
          DialogRequest(
            type: DialogType.progress,
            title: "Checking login detail...",
          ),
        );

        await _loginWithPin();
      } else if (!_showLoginWithPin &&
          loginWithUsernamePasswordFormKey.currentState!.validate()) {
        dialog.showDialog(
          DialogRequest(
            type: DialogType.progress,
            title: "Checking login detail...",
          ),
        );
        await _loginWithUsernameAndPassword();
      }
      dialog.hideDialog();
    } catch (e) {
      dialog.hideDialog();
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> _loginWithUsernameAndPassword() async {
    try {
      await _authenticationService.authByUsername(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );

      if (_rememberMe) {
        await _authenticationService.saveUsername(_usernameController.text);
      }

      await locator<CompanyService>().init();

      setSuccess();
      gotoAndClear(DashboardView.tag);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loginWithPin() async {
    try {
      await _authenticationService.authByPin(
        pin: _pinController.text,
      );

      await locator<CompanyService>().init();

      setSuccess();
      gotoAndClear(DashboardView.tag);
    } catch (e) {
      rethrow;
    }
  }
}
