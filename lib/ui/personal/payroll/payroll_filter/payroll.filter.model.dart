import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/payroll.service.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.model.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.view.dart';

import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';

import '../../../../data_models/payroll.data.dart';

class PayrollFilterModel extends ViewModel with SnackbarMixin, DialogMixin {
  //Service
  final PayrollService _payrollService = locator<PayrollService>();

  //Data
  List<PayrollData> _payrolls = [];
  List<PayrollData> get payroll => _payrolls;

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
  late String _selectedMonth;
  String get selectedMonth => _selectedMonth;
  set selectedMonth(String value) {
    _selectedMonth = value;
    if (_selectedMonth == "January") {
      _dateFrom = DateTime.utc(DateTime.now().year, 1);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "February") {
      _dateFrom = DateTime.utc(DateTime.now().year, 2);
      _dateTo = _dateFrom?.add(const Duration(days: 27));
    } else if (_selectedMonth == "March") {
      _dateFrom = DateTime.utc(DateTime.now().year, 3);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "April") {
      _dateFrom = DateTime.utc(DateTime.now().year, 4);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "May") {
      _dateFrom = DateTime.utc(DateTime.now().year, 5);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "June") {
      _dateFrom = DateTime.utc(DateTime.now().year, 6);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "July") {
      _dateFrom = DateTime.utc(DateTime.now().year, 7);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "August") {
      _dateFrom = DateTime.utc(DateTime.now().year, 8);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "September") {
      _dateFrom = DateTime.utc(DateTime.now().year, 9);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "October") {
      _dateFrom = DateTime.utc(DateTime.now().year, 10);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "November") {
      _dateFrom = DateTime.utc(DateTime.now().year, 11);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "December") {
      _dateFrom = DateTime.utc(DateTime.now().year, 12);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    }

    setIdle();
  }

  bool _returnBack = false;

  DateTime? _dateFrom;
  DateTime? get dateFrom => _dateFrom;
  DateTime? _dateTo;
  DateTime? get dateTo => _dateTo;
  set dateFrom(DateTime? value) {
    _dateFrom = value;
    _dateTo = _dateFrom?.add(const Duration(days: 31));
    setIdle();
  }

  //Action
  Future<void> init(PayrollFilterArguments arguments) async {
    _returnBack = arguments.returnBack;
    _selectedMonth = months[DateTime.now().month - 1];
    setIdle();
  }

  void onViewPayrollPressed() {
    Map<String, dynamic> _searchParams = {};

    _searchParams['date_from'] =
        "${DateTime.now().year}-${(months.indexOf(_selectedMonth) + 1).toString().length == 1 ? '0${months.indexOf(_selectedMonth) + 1}' : months.indexOf(_selectedMonth) + 1}-01";
    _searchParams['date_to'] =
        lastDateOfMonth(months.indexOf(_selectedMonth) + 1);

    if (_returnBack) {
      goBack(result: PayrollArgument(searchParams: _searchParams));
    } else {
      gotoAndPop(PayrollView.tag,
          arguments: PayrollArgument(searchParams: _searchParams));
    }
  }
}
