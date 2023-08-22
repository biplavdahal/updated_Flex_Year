import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/upcoming_birthday/upcoming_birthday.viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/upcoming_birthday/widget/birthday_widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AllStaffBirthdayView extends StatelessWidget {
  static String tag = 'comming-birthday-view';

  const AllStaffBirthdayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AllStaffBirthdayModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Upcoming Birthday's"),
          ),
          body: RefreshIndicator(
            onRefresh: model.init,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (model.isLoading) const FYLinearLoader(),
                if (!model.isLoading)
                  if (model.allStaffBirthdayData.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final _birthday = model.allStaffBirthdayData[index];
                          return BirthdayItem(birthdayData: _birthday);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 0,
                        ),
                        itemCount: model.allStaffBirthdayData.length,
                      ),
                    )
                  else
                    const Expanded(
                        child: Center(
                      child: Text('No Upcomming Birthday!!'),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
