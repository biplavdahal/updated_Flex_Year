import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/widget/payroll_item.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/fy_date_time_field.widget.dart';
import '../../../../widgets/fy_dropdown.widget.dart';

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
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.topRight, child: Text("Nepali")),
                    _buildFieldForMonthlyReportFilter(model),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildFieldForWeeklyReportFilter(model),
                    const SizedBox(
                      height: 10,
                    ),
                    FYPrimaryButton(
                      label: "View Payroll",
                      onPressed: model.onViewPayrollPressed,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldForMonthlyReportFilter(PayrollFilterModel model) {
    return FYDropdown<String>(
      items: model.months,
      labels: model.months,
      value: model.selectedMonth,
      title: 'Month',
      onChanged: (value) => model.selectedMonth = value!,
    );
  }

  Widget _buildFieldForWeeklyReportFilter(PayrollFilterModel model) {
    return Row(
      children: [
        Expanded(
          child: FYDateField(
            title: "Date From",
            onChanged: (value) => model.dateFrom = value!,
            value: model.dateFrom,
            firstDate: DateTime.now().subtract(
              const Duration(days: 365 * 7),
            ),
            lastDate: DateTime.now(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FYDateField(
            title: "Date To",
            value: model.dateTo,
          ),
        ),
      ],
    );
  }
}
