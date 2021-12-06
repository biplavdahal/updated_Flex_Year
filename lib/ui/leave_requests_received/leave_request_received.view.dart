import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/leave_requests_received/leave_request_received.model.dart';
import 'package:flex_year_tablet/ui/leave_requests_received/widgets/request_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class LeaveRequestReceivedView extends StatelessWidget {
  static String tag = 'leave-request-received-view';

  const LeaveRequestReceivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<LeaveRequestReceivedModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Leave Request Received'),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: RefreshIndicator(
                    onRefresh: model.init,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: model.requests.length,
                      itemBuilder: (ctx, index) {
                        final leaveRequest = model.requests[index];
                        return RequestItem(
                          request: leaveRequest,
                          isBusy: model.isBusyWidget('$leaveRequest-request'),
                          onApprove: model.onApprove,
                          onDecline: model.onDecline,
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}
