import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/flex_calander/calander.model.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/flex_calander/widget/calander.item.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/flex_calander/widget/nepalicalander.item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class CalanderView extends StatefulWidget {
  static String tag = 'calander-view';

  const CalanderView({
    Key? key,
  }) : super(key: key);

  @override
  State<CalanderView> createState() => _CalanderViewState();
}

class _CalanderViewState extends State<CalanderView> {
  @override
  Widget build(BuildContext context) {
    return FrontView<CalanderModel>(
      enableTouchRepeal: true,
      killViewOnClose: false,
      
      onModelReady: (model) async {
        await model.init();
      },
      builder: (ctx, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Flex Calendar'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(4),
              child: FutureBuilder<void>(
                future: model.init(),
                
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const FYLinearLoader();
                  } else if (snapshot.hasError) {
                    return Expanded(
                        child: Center(child: Text('Error: ${snapshot.error}')));
                  } else if (model.company.companyPreference == 'N') {
                    return NepaliCalanderItems(
                        monthlyReport: model.monthlyReport);
                  } else {
                    return CalanderItems(
                      monthlyReport: model.monthlyReport,
                    );
                  }
                },
              ),
            ));
      },
    );
  }
}
