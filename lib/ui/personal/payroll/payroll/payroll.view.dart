import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/payroll.model.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll/widget/payroll_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class payrollView extends StatelessWidget {
  static String tag = 'payroll-view';

  const payrollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<PayrollModel>(
      onModelReady: (model) => model.init(),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
            appBar: AppBar(title: const Text('Payroll')),
            floatingActionButton: FloatingActionButton(
              child: const Icon(MdiIcons.filter),
              tooltip: "Filter",
              onPressed: () async {},
            ),
            body: model.isLoading
                ? const FYLinearLoader()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: RefreshIndicator(
                        onRefresh: model.init,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final _payroll = model.payroll[index];
                            return PayrollItem(
                              payroll: _payroll,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 0,
                            );
                          },
                          itemCount: model.payroll.length,
                        )),
                  ));
      },
    );
  }
}
