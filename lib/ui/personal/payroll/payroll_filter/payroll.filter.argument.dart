import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/payroll.data.dart';

class PayrollFilterArguments extends Arguments {
  final String fromdate;
  final String todate;

  PayrollFilterArguments({required this.fromdate, required this.todate});
}
