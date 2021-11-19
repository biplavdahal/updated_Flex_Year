import 'package:bestfriend/ui/view.model.dart';
import 'package:flutter/material.dart';

class LoginModel extends ViewModel {
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
  Future<void> login() async {}
}
