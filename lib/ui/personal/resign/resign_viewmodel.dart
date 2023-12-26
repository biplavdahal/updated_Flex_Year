import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/exit_process.service.dart';
import 'package:flutter/widgets.dart';

class ResignViewModel extends ViewModel with SnackbarMixin, DialogMixin {
//service
  final ExitProcess _exitProcess = locator<ExitProcess>();

  List<ResignData> _resignData = [];
  List<ResignData> get resignData => _resignData;

  // UI Controllers and keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  DateTime? _resignDate;
  DateTime? get resignDate => _resignDate;
  set resignDate(DateTime? value) {
    _resignDate = value;
    setIdle();
  }

  final TextEditingController _resignLetterController = TextEditingController();
  TextEditingController get resignLetterController => _resignLetterController;

  final TextEditingController _resignFeedbackController =
      TextEditingController();
  TextEditingController get resignFeedbackController =>
      _resignFeedbackController;

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

  Future<void> onSubmitResignData() async {
    try {
      dialog.showDialog(
          DialogRequest(type: DialogType.progress, title: 'Creating resign..'));

      await _exitProcess.createResignRequest(prepareData());
      dialog.hideDialog();
      goBack(result: true);
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Map<String, dynamic> prepareData() {
    Map<String, dynamic> data = {};

    data['letter'] = _resignLetterController.text;
    data['feedback'] = _resignFeedbackController.text;
    data['date'] = _resignDate.toString();

    return data;
  }
}
