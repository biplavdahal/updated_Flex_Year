import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/notifications/notification.model.dart';
import 'package:flex_year_tablet/ui/personal/notifications/widget/notification.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AllNotificationView extends StatelessWidget {
  static String tag = 'notification';

  const AllNotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrontView<AllNotificationModel>(
        onModelReady: (model) => model.init(),
        killViewOnClose: false,
        builder: (ctx, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notifications'),
            ),
            body: RefreshIndicator(
              onRefresh: model.init,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.isLoading) const FYLinearLoader(),
                  if (!model.isLoading)
                    if (model.allNotificationData.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final _data = model.allNotificationData[index];
                            return NotificationItem(data: _data);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                          itemCount: model.allNotificationData.length,
                        ),
                      )
                    else
                      const Expanded(
                          child: Center(
                        child: Text('No Notifications !!'),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
