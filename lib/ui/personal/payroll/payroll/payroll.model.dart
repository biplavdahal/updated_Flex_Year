import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/payroll.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/payroll.service.dart';

class PayrollModel extends ViewModel with SnackbarMixin, DialogMixin {
  //Service
  final PayrollService _payrollService = locator<PayrollService>();

  //Data

  List<PayrollData> _payrolls = [];
  List<PayrollData> get payroll => _payrolls;

  Future<void> init() async {
    try {
      setLoading();
      _payrolls = await _payrollService.getAllPayrolls();
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
