import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/payroll.service.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import '../../../../data_models/company.data.dart';
import '../../../../data_models/payroll.data.dart';
import '../../../../services/app_access.service.dart';

class PayrollFilterModel extends ViewModel with SnackbarMixin, DialogMixin {
  //Service
  final PayrollService _payrollService = locator<PayrollService>();

  //Data
  List<PayrollData> _payrolls = [];
  List<PayrollData> get payroll => _payrolls;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  CompanyData get company => locator<AppAccessService>().appAccess!.company;

  List<String> get nepaliMonths => [
        "बैशाख",
        "जेष्ठ",
        "आषाढ़",
        "श्रावण",
        "भाद्र",
        "आश्विन",
        "कार्तिक",
        "मंसिर",
        "पौष",
        "माघ",
        "फाल्गुन",
        "चैत्र",
      ];
  late String _selectedNepaliMonth;
  String get selectedNepaliMonth => _selectedNepaliMonth;
  set selectedNepaliMonth(String value) {
    _selectedNepaliMonth = value;

    int nepaliMonth;

    switch (_selectedNepaliMonth) {
      case 'बैशाख':
        nepaliMonth = 1;
        break;
      case 'जेष्ठ':
        nepaliMonth = 2;
        break;
      case 'आषाढ़':
        nepaliMonth = 3;
        break;
      case 'श्रावण':
        nepaliMonth = 4;
        break;
      case 'भाद्र':
        nepaliMonth = 5;
        break;
      case 'आश्विन':
        nepaliMonth = 6;
        break;
      case 'कार्तिक':
        nepaliMonth = 7;
        break;
      case 'मंसिर':
        nepaliMonth = 8;
        break;
      case 'पौष':
        nepaliMonth = 9;
        break;
      case 'माघ':
        nepaliMonth = 10;
        break;
      case 'फाल्गुन':
        nepaliMonth = 11;
        break;
      case 'चैत्र':
        nepaliMonth = 12;
        break;
      default:
        nepaliMonth = NepaliDateTime.now().month;
    }

    final NepaliDateTime startNepaliDate =
        NepaliDateTime(NepaliDateTime.now().year, nepaliMonth, 1);

    final NepaliDateTime endNepaliDate = NepaliDateTime(
        NepaliDateTime.now().year,
        nepaliMonth,
        NepaliDateTime(NepaliDateTime.now().year, nepaliMonth, 1).totalDays);

    _nepaliDateFrom = startNepaliDate;
    _nepaliDateTo = endNepaliDate;

    setIdle();
  }

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

  //English action
  DateTime? _dateFrom;
  DateTime? get dateFrom => _dateFrom;
  DateTime? _dateTo;
  DateTime? get dateTo => _dateTo;
  set dateFrom(DateTime? value) {
    _dateFrom = value;
    _dateTo = _dateFrom?.add(const Duration(days: 31));
    setIdle();
  }

  //Nepali action
  NepaliDateTime? _nepaliDateFrom;
  NepaliDateTime? get nepaliDateFrom => _nepaliDateFrom;
  NepaliDateTime? _nepaliDateTo;
  NepaliDateTime? get nepaliDateTo => _nepaliDateTo;

  set nepaliDateFrom(NepaliDateTime? value) {
    _nepaliDateFrom = value;
    _nepaliDateTo = _nepaliDateFrom?.add(const Duration(days: 31));
    setIdle();
  }

  set nepaliDateTo(NepaliDateTime? value) {
    _nepaliDateTo = value;
    setIdle();
  }

  //Action
  Future<void> init(PayrollFilterArguments arguments) async {
    _returnBack = arguments.returnBack;
    _selectedNepaliMonth = nepaliMonths[DateTime.now().month - 1];
    setIdle();
  }

  void onViewPayrollPressed() {
    Map<String, dynamic> _searchParams = {};

    _searchParams['date_from'] = nepaliDateFrom;
    _searchParams['date_to'] = nepaliDateTo;

    // if(isNepaliDate ==true){
    //   _searchParams['date_from'] =
    // }

    if (_returnBack) {
      goBack(result: PayrollArgument(searchParams: _searchParams));
    } else {
      gotoAndPop(PayrollView.tag,
          arguments: PayrollArgument(searchParams: _searchParams));
    }
  }
}
