import 'package:bestfriend/di.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.model.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/widgets/leave_request_item.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.view.dart';
import 'package:flex_year_tablet/widgets/fy_shimmer.widget.dart';
import 'package:flutter/material.dart';
import '../dashboard/dashboard.model.dart';

class LeaveRequestView extends StatelessWidget {
  static String tag = 'leave-request-view';

  const LeaveRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = locator<DashboardModel>().user;
    final ScrollController _scrollController = ScrollController();
    return View<LeaveRequestModel>(
      onDispose: (model) {
        _scrollController.dispose();
      },
      onModelReady: (model) async {
        await model.init();
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            model.loadMore();
          }
        });
      },
      initState: (model) {
        _scrollController.addListener(() {
          if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset) {
            model.loadMore();
          }
        });
      },
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Leave Requests'),
          ),

          floatingActionButton: Stack(
            children: [
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () async {
                    final response =
                        await model.goto(WriteLeaveRequestView.tag);
                    if (response != null) {
                      model.init();
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.grey[300],
                      padding: const EdgeInsets.all(2),
                    ),
                    onPressed: () async {
                      model.loadMore();
                    },
                    child: const Text('Tap to loadMore...'),
                  ),
                ),
              )
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(Icons.add),
          //   onPressed: () async {
          //     final response = await model.goto(WriteLeaveRequestView.tag);
          //     if (response != null) {
          //       model.init();
          //     }
          //   },
          // ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Remaining Leave Days : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${_user.staff.remainingLeave} " + 'days',
                      style: const TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    model.tabs.length,
                    (index) => ChoiceChip(
                      label: Text(model.tabs[index]),
                      selected: model.selectedTab == index.toString(),
                      onSelected: (_) => model.selectedTab = index.toString(),
                      selectedColor: Colors.black38,
                    ),
                  ),
                ),
                if (model.isLoading)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => getShimmerLoading(),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 30,
                            ),
                        itemCount: 9),
                  ),
                const SizedBox(height: 16),
                if (!model.isLoading)
                  if (model.requestsToShow.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: model.init,
                        child: ListView.separated(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DelayedDisplay(
                                child: LeaveRequestItem(
                                  index: index,
                                  request: model.requestsToShow[index],
                                  isBusy: model.isBusyWidget(
                                      model.requestsToShow[index].id),
                                  onRemoveTap: model.removeLeave,
                                  onEditTap: model.onUpdatePressed,
                                  onApprove: model.onApprove,
                                  onDecline: model.onDecline,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: model.requestsToShow.length),
                      ),
                    )
                  else if (model.selectedTab == '0')
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: model.init,
                      child: ListView.separated(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DelayedDisplay(
                              child: LeaveRequestItem(
                                index: index,
                                request: model.request[index],
                                isBusy:
                                    model.isBusyWidget(model.request[index].id),
                                onRemoveTap: model.removeLeave,
                                onEditTap: model.onUpdatePressed,
                                onApprove: model.onApprove,
                                onDecline: model.onDecline,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: model.request.length),
                    ))
                  else
                    const Expanded(
                        child: Center(child: Text("No Leave Request ...")))
              ],
            ),
          ),
        );
      },
    );
  }
}
