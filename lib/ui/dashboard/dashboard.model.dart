import 'dart:async';

import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/company.data.dart';
import 'package:flex_year_tablet/data_models/company_logo.data.dart';
import 'package:flex_year_tablet/data_models/user.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/ui/login/login.view.dart';

class DashboardModel extends ViewModel with DialogMixin, SnackbarMixin {
  // Data
  CompanyData get company => locator<AppAccessService>().appAccess!.company;
  CompanyLogoData get logo => locator<AppAccessService>().appAccess!.logo;
  UserData get user => locator<AuthenticationService>().user!;

  String _currentDateTime = DateTime.now().toString();
  String get currentDateTime => _currentDateTime;

  late Timer? _currentDateTimeTimer;

  // Actions
  Future<void> init() async {
    _currentDateTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDateTime = DateTime.now().toString();
      setIdle();
    });
  }

  Future<void> logout() async {
    try {
      dialog.showDialog(
        DialogRequest(
          type: DialogType.progress,
          title: "Logging you out...",
        ),
      );
      await locator<AuthenticationService>().logout();
      _currentDateTimeTimer?.cancel();
      dialog.hideDialog();
      gotoAndClear(LoginView.tag);
    } catch (e) {
      dialog.hideDialog();
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
