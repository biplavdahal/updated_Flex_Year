import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/user_cleareance_data.dart';
import 'package:flex_year_tablet/data_models/user_exit_survey.data.dart';
import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/exit_process.service.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data_models/company.data.dart';
import '../../../data_models/company_logo.data.dart';
import '../../../services/app_access.service.dart';

class ResignViewModel extends ViewModel with SnackbarMixin, DialogMixin {
//service
  final ExitProcess _exitProcess = locator<ExitProcess>();

  List<ResignData> _resignData = [];
  List<ResignData> get resignData => _resignData;

  List<Clearancedata> _clearanceData = [];
  List<Clearancedata> get clearanceData => _clearanceData;
  CompanyLogoData get logo => locator<AppAccessService>().appAccess!.logo;
  CompanyData get company => locator<AppAccessService>().appAccess!.company;

  List<ExitSurveyData> _exitSurveyData = [];
  List<ExitSurveyData> get exitSurveyData => _exitSurveyData;

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

  bool _isEditMode = false;
  String? _requestId;

  Future<void> init(ResighViewArguments? arguments) async {
    if (arguments?.resign != null) {
      _isEditMode = true;
      _requestId = arguments!.resign!.id;
      _resignDate = DateTime.parse(arguments.resign!.date.toString());
      _resignLetterController.text = arguments.resign!.letter.toString();
      _resignFeedbackController.text = arguments.resign!.feedBack.toString();
    } else {
      _resignLetterController.text = '';
      _resignFeedbackController.text = '';
      _resignDate = resignDate;
    }
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

  Future<void> Clearanceinit() async {
    try {
      setLoading();

      _clearanceData = await _exitProcess.getClearanceDetail();

      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> ExitSurveyinit() async {
    try {
      setLoading();

      _exitSurveyData = await _exitProcess.getQuestions();

      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
