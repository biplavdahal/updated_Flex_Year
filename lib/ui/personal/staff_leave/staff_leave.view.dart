import 'package:bestfriend/di.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/widgets/request_item.dart';
import 'package:flex_year_tablet/ui/personal/staff_leave/staff_leave.model.dart';
import 'package:flutter/material.dart';
import '../../../widgets/fy_shimmer.widget.dart';
import '../dashboard/dashboard.model.dart';

class StaffLeaveView extends StatelessWidget {
  static String tag = 'staff-leave-view';

  const StaffLeaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = locator<DashboardModel>().user;
    final ScrollController _scrollController = ScrollController();
    return FrontView<StaffLeavemodel>(
      onDispose: (model) {
        _scrollController.dispose();
      },
      onModelReady: (model) async {
        await model.init();
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            // model.loadMore();
          }
        });
      },
      initState: (model) {
        _scrollController.addListener(() {
          if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset) {
            // model.loadMore();
          }
        });
      },
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Staff on Leave'),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  child: RequestItem(
                                request: model.requestsToShow[index],
                              ));
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: model.requestsToShow.length),
                      ),
                    )
                  else
                    const Expanded(
                      child: Center(
                        child: Text('No Staff on leave'),
                      ),
                    )
              ],
            ),
          ),
        );
      },
    );
  }
}
