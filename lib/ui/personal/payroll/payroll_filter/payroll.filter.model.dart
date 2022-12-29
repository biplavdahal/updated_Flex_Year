import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/payroll.service.dart';
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

  //Action
  Future<void> init(PayrollFilterArguments arguments) async {
    try {
      setLoading();
      _payrolls = await _payrollService.getAllPayrolls(
          fromDate: arguments.fromdate, toDate: arguments.todate);
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
