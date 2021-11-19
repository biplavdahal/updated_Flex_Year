import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/ui/login/login.view.dart';
import 'package:flutter/material.dart';

class AppAccessModel extends ViewModel with SnackbarMixin {
  // Services
  final AppAccessService _appAccessService = locator<AppAccessService>();

  // UI Controllers
  final GlobalKey<FormState> _appAccessFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get appAccessFormKey => _appAccessFormKey;

  final TextEditingController _appAccessController = TextEditingController();
  TextEditingController get appAccessController => _appAccessController;

  // Action
  Future<void> onVerifyKeyPressed() async {
    if (_appAccessFormKey.currentState!.validate()) {
      try {
        setLoading();
        await _appAccessService.getApAccess(appAccessController.text);
        gotoAndClear(LoginView.tag);
        setSuccess();
      } catch (e) {
        setIdle();
        snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
      }
    }
  }
}
