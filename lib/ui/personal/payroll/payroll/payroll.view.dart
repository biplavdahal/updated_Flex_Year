import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.model.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/widget/payroll_item.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PayrollView extends StatefulWidget {
  static String tag = 'payroll-view';

  const PayrollView({Key? key}) : super(key: key);

  @override
  State<PayrollView> createState() => _PayrollViewState();
}

class _PayrollViewState extends State<PayrollView> {
  String _data = "sd";
  void _updateData(String newData) {
    setState(() {
      _data = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return View<PayrollModel>(
      onModelReady: (model) => model.init(),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Payroll'),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              MdiIcons.filter,
              semanticLabel: "Filter",
            ),
            tooltip: "Filter",
            onPressed: () async {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: SingleChildScrollView(
                          child: Form(
                            key: model.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // _buildFieldForPayrollMonth(model),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: FYDateField(
                                                    title: 'Date From',
                                                    onChanged: (value) =>
                                                        model.datefrom = value!,
                                                    value: model.datefrom,
                                                    firstDate: DateTime.now()
                                                        .subtract(
                                                            const Duration(
                                                                days:
                                                                    365 * 32)),
                                                    lastDate: DateTime.now(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: FYDateField(
                                                    title: "Date To",
                                                    value: model.dateUpto,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                FYPrimaryButton(
                                                  label: "  CANCEL  ",
                                                  backgroundColor:
                                                      Colors.grey.shade600,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                FYPrimaryButton(
                                                    label: "  SEARCH  ",
                                                    onPressed:
                                                        model.onSubmitPressed),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                  });
            },
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final _payroll = model.payroll[index];

                        return PayrollItem(
                          payroll: _payroll,
                        );
                      },
                      itemCount: model.payroll.length,
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildFieldForPayrollMonth(PayrollModel model) {
    return FYDropdown<String>(
      items: model.months,
      labels: model.months,
      value: model.selectedMonth.toString(),
      title: 'Month',
      onChanged: (value) => model.selectedMonth = value!,
    );
  }

  Widget _buildFieldForPayrollDate(PayrollModel model) {
    return Row(
      children: [
        Expanded(
          child: FYDateField(
            title: 'Date From',
            onChanged: (value) => model.datefrom = value!,
            value: model.datefrom,
            firstDate: DateTime.now().subtract(const Duration(days: 365 * 32)),
            lastDate: DateTime.now(),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: FYDateField(
            title: "Date To",
            value: model.dateUpto,
          ),
        )
      ],
    );
  }
}
