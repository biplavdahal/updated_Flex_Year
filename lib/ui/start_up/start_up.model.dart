import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.view.dart';
import 'package:flex_year_tablet/ui/login/login.view.dart';

class StartUpModel extends ViewModel with SnackbarMixin {
  // Services
  final AppAccessService _appAccessService = locator<AppAccessService>();

  Future<void> init() async {
    try {
      setLoading();
      await _appAccessService.init();

      if (_appAccessService.appAccess != null) {
        gotoAndClear(LoginView.tag);
      } else {
        gotoAndClear(AppAccessView.tag);
      }

      setSuccess();
    } catch (e) {
      setAlert(viewState: EState.error, message: e.toString());
    }
  }
}
