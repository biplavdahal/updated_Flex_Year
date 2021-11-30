import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/holidays/widgets/holiday_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class HolidaysView extends StatelessWidget {
  static String tag = 'holidays-view';

  const HolidaysView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<HolidaysModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Holidays'),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                    onRefresh: model.init,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: model.holidays.length,
                      itemBuilder: (ctx, index) {
                        final holiday = model.holidays[index];
                        return HolidayItem(holiday);
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}
