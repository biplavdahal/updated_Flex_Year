import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/exit_process.service.dart';

class ResignViewModel extends ViewModel with SnackbarMixin, DialogMixin {
//service
  final ExitProcess _exitProcess = locator<ExitProcess>();

  List<ResignData> _resignData = [];
  List<ResignData> get resignData => _resignData;

  Future<void> init() async {
    try {
      setLoading();

      _resignData = await _exitProcess.getResignData();

      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
