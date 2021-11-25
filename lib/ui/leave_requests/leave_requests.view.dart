import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/leave_requests/leave_requests.model.dart';
import 'package:flex_year_tablet/ui/leave_requests/widgets/leave_request_item.dart';
import 'package:flex_year_tablet/ui/write_leave_request/write_leave_request.view.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class LeaveRequestView extends StatelessWidget {
  static String tag = 'leave-request-view';

  const LeaveRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<LeaveRequestModel>(
      onModelReady: (model) => model.init(),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Leave Requests'),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final response = await model.goto(WriteLeaveRequestView.tag);
              if (response != null) {
                model.init();
              }
            },
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    model.tabs.length,
                    (index) => ChoiceChip(
                      label: Text(model.tabs[index]),
                      selected: model.selectedTab == index.toString(),
                      onSelected: (_) => model.selectedTab = index.toString(),
                    ),
                  ),
                ),
                if (model.isLoading) const FYLinearLoader(),
                const SizedBox(height: 16),
                if (!model.isLoading)
                  if (model.requestsToShow.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: model.init,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return LeaveRequestItem(
                              request: model.requestsToShow[index],
                              isBusy: model
                                  .isBusyWidget(model.requestsToShow[index].id),
                              onRemoveTap: model.removeLeave,
                              onEditTap: model.onUpdatePressed,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: model.requestsToShow.length,
                        ),
                      ),
                    )
                  else
                    const Expanded(
                      child: Center(
                        child: Text('No leave requests'),
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
