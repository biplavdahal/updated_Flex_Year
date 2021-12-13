import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/frontdesk/enter_pin/enter_pin.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.view.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';
import 'package:flutter/services.dart';

class StartUpModel extends ViewModel with SnackbarMixin {
  // Services
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<void> init() async {
    try {
      setLoading();
      await _appAccessService.init();

      if (_appAccessService.appAccess != null) {
        if (_appAccessService.appUsage == null) {
          gotoAndClear(AppAccessView.tag);
        } else {
          if (_appAccessService.appUsage == "PERSONAL") {
            final _isLoggedIn = await _authenticationService.isLoggedIn();
            if (_isLoggedIn) {
              await locator<CompanyService>().init();
              gotoAndClear(DashboardView.tag);
            } else {
              gotoAndClear(LoginView.tag);
            }
          } else {
            if (_appAccessService.client == null) {
              gotoAndClear(AppAccessView.tag);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
              gotoAndClear(EnterPinView.tag);
            }
          }
        }
      } else {
        gotoAndClear(AppAccessView.tag);
      }

      setSuccess();
    } catch (e) {
      setAlert(viewState: EState.error, message: e.toString());
      _authenticationService.logout();
      gotoAndClear(LoginView.tag);
    }
  }
}
