import 'package:bestfriend/bestfriend.dart';

class PayrollArgument extends Arguments {
  final Map<String, dynamic> searchParams;
  final String month;

  PayrollArgument({required this.searchParams, required this.month});
}
