import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
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


  //Data
  List<PayrollData> _payrolls = [];
  List<PayrollData> get payroll => _payrolls;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  CompanyData get company => locator<AppAccessService>().appAccess!.company;

  List<String> get nepaliMonths => [
        "Baisakh",
        "Jestha",
        "Asadh",
        "Shrawan",
        "Bhadra",
        "Ashoj",
        "Kartik",
        "Mangshir",
        "Poush",
        "Magh",
        "Falgun",
        "Chaitra",
      ];
  late String _selectedNepaliMonth;
  String get selectedNepaliMonth => _selectedNepaliMonth;
  set selectedNepaliMonth(String value) {
    _selectedNepaliMonth = value;

    int nepaliMonth;

    switch (_selectedNepaliMonth) {
      case 'Baisakh':
        nepaliMonth = 1;
        break;
      case 'Jestha':
        nepaliMonth = 2;
        break;
      case 'Asadh':
        nepaliMonth = 3;
        break;
      case 'Shrawan':
        nepaliMonth = 4;
        break;
      case 'Bhadra':
        nepaliMonth = 5;
        break;
      case 'Ashoj':
        nepaliMonth = 6;
        break;
      case 'Kartik':
        nepaliMonth = 7;
        break;
      case 'Mangshir':
        nepaliMonth = 8;
        break;
      case 'Poush':
        nepaliMonth = 9;
        break;
      case 'Magh':
        nepaliMonth = 10;
        break;
      case 'Falgun':
        nepaliMonth = 11;
        break;
      case 'Chaitra':
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

    _searchParams['date_from'] =
        nepaliDateFrom?.toDateTime().toString().substring(0, 10);
    _searchParams['date_to'] =
        nepaliDateTo?.toDateTime().toString().substring(0, 10);

    // // if(isNepaliDate ==true){
    // //   _searchParams['date_from'] =
    // // }

    if (_returnBack) {
      goBack(result: PayrollArgument(searchParams: _searchParams, month: selectedNepaliMonth));
    } else {
      gotoAndPop(PayrollView.tag,
          arguments: PayrollArgument(searchParams: _searchParams, month: selectedNepaliMonth));
    }
  }
}
