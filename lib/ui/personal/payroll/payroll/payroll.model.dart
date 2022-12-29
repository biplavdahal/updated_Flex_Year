import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/payroll.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/payroll.service.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flutter/material.dart';

class PayrollModel extends ViewModel with SnackbarMixin, DialogMixin {
  //UI components
  final TextEditingController _weekdayController = TextEditingController();
  TextEditingController get weekdayController => _weekdayController;

  final TextEditingController _fromTimeController = TextEditingController();
  TextEditingController get fromTimeController => _fromTimeController;

  final TextEditingController _toTimeController = TextEditingController();
  TextEditingController get toTimeController => _toTimeController;

  //Service
  final PayrollService _payrollService = locator<PayrollService>();

  //Data

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  List<String> get months => [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      ];
  String? _selectedMonth;
  String? get selectedMonth => _selectedMonth;
  set selectedMonth(String? value) {
    _selectedMonth = _status[months];
    setIdle();
  }

  final _status = {
    "2022-01-00": "January",
    "2022-02-00": "Febrary",
    "2022-03-00": "March",
    "2022-04-00": "April",
    "2022-05-00": "May",
    "2022-06-00": "June",
    "2022-07-00": "July",
    "2022-08-00": "August",
    "2022-09-00": "September",
    "2022-10-00": "October",
    "2022-11-00": "November",
    "2022-12-00": "December"
  };

  // 'date_from': "2022-04-14",
  //         'date_to': "2023-01-14"
  String get dateFrom => "2022-04-14";

  String get dateTo => "2023-01-14";

  DateTime? _datefrom;
  DateTime? get datefrom => _datefrom;
  DateTime? _dateUpto;
  DateTime? get dateUpto => _dateUpto;
  set datefrom(DateTime? value) {
    _datefrom = value;
    _dateUpto = _datefrom?.add(const Duration(days: 31));
    setIdle();
  }

  List<PayrollData> _payrolls = [];
  List<PayrollData> get payroll => _payrolls;

  void updateData() async {
    _payrolls = await _payrollService.getAllPayrolls(
        fromDate: datefrom.toString(), toDate: dateUpto.toString());
    goBack();
  }

  Future<void> init() async {
    try {
      setLoading();
      _payrolls = await _payrollService.getAllPayrolls(
          fromDate: dateFrom, toDate: dateTo);
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onSubmitPressed() async {
    try {
      dialog.showDialog(DialogRequest(
          type: DialogType.progress,
          title: "Searching payroll from ${datefrom} to ${dateUpto}"));
      goBack(result: true);
      dialog.hideDialog();
      await goto(PayrollFilterView.tag,
          arguments: PayrollFilterArguments(
              fromdate: datefrom.toString(), todate: dateUpto.toString()));
    } catch (e) {
      dialog.hideDialog();

      Fluttertoast.showToast(msg: "${e}");
    }
  }

  Future<void> onFromTimePressed(BuildContext context) async {
    final _selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: 'SET',
      helpText:
          "Every session can be only 1 hour long and the minutes set will be ignored.",
    );

    if (_selectedTime != null) {
      _fromTimeController.text =
          _selectedTime.replacing(minute: 0).format(context);
      _toTimeController.text = _selectedTime
          .replacing(
            hour: _selectedTime.hour + 1,
            minute: 0,
          )
          .format(context);
      setIdle();
    }
  }
}
