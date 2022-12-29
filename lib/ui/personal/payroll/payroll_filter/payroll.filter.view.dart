import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/widget/payroll_item.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.model.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class PayrollFilterView extends StatelessWidget {
  static String tag = 'payroll-filter-view';

  final Arguments? arguments;

  const PayrollFilterView(
    this.arguments, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<PayrollFilterModel>(
      onModelReady: (model) => model.init(arguments as PayrollFilterArguments),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Payroll Search'),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopInfoBar(model),
                const SizedBox(
                  height: 16,
                ),
                _buildData(model),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopInfoBar(PayrollFilterModel model) {
    return const SizedBox(
        child: Card(
      color: Colors.white10,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          "from:  to: ",
        ),
      ),
    ));
  }

  Widget _buildData(PayrollFilterModel model) {
    if (model.isLoading) {
      return const FYLinearLoader();
    }
    if (model.payroll.isEmpty) {
      return const Expanded(
          child: Center(
        child: Text('No Payroll Found'),
      ));
    }
    return Expanded(
        child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final _payroll = model.payroll[index];
        return PayrollItem(payroll: _payroll);
      },
      itemCount: model.payroll.length,
    ));
  }
}
