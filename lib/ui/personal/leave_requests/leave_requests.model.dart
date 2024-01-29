import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/leave.service.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.arguments.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.view.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../dashboard/dashboard.model.dart';

class LeaveRequestModel extends ViewModel with SnackbarMixin, DialogMixin {
  // Service
  final LeaveService _leaveService = locator<LeaveService>();
  int _limit = 5;

  // Data
  List<String> get tabs => ['All', 'Pending', 'Approved', 'Declined'];

  String _selectedTab = "0";
  String get selectedTab => _selectedTab;

  set selectedTab(String tab) {
    _selectedTab = tab;
    setIdle();
  }

  bool light = false;

  List<LeaveRequestData> _requests = [];
  final _status = {"0": "1", "1": "2", "2": "3", "": "0"};
  List<LeaveRequestData> get requestsToShow => _requests
      .where((request) => _status[request.status] == _selectedTab)
      .toList();
  List<LeaveRequestData> get request => _requests;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // Action
  Future<void> init() async {
    try {
      setLoading();

      _requests = await _leaveService.getAllLeaveRequests(limit: _limit);

      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  bool isDataFinishedScrolling = false;

  Future<void> loadMore() async {
    if (_leaveService.hasMoreData) {
      setWidgetBusy('load-more');
    }
    _limit = _limit + 5;
    try {
      _requests = await _leaveService.getAllLeaveRequests(limit: _limit);

      setIdle();
    } catch (e) {
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> removeLeave(String id) async {
    try {
      final isConfirm = await dialog.showDialog(
        DialogRequest(
          type: DialogType.confirmation,
          title: "Are you sure you want to delete leave request?",
          dismissable: true,
        ),
      );

      if (isConfirm?.result != null) {
        setWidgetBusy("$id-request");
        await _leaveService.deleteLeaveRequest(id);

        _requests.removeWhere((request) => request.id == id);

        unsetWidgetBusy("$id-request");
      }
      init();
    } catch (e) {
      unsetWidgetBusy("$id-request");
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onUpdatePressed(LeaveRequestData request) async {
    final response = await goto(
      WriteLeaveRequestView.tag,
      arguments: WriteLeaveRequestViewArguments(request),
    );
    if (response != null) {
      init();
    }
  }

  Future<void> onApprove(String requestId) async {
    try {
      final isConfirm = await dialog.showDialog(DialogRequest(
          type: DialogType.confirmation,
          title: "Are you sure you want to approve request",
          dismissable: true));
      if (isConfirm?.result != null) {
        setWidgetBusy('$requestId-request');
        await _leaveService.actionOnLeaveRequest(
            requestId: requestId, action: "1");

        // update correction status of review from reviews where id == attendanceId
        _requests = _requests.map((request) {
          if (request.id == requestId) {
            return request.copyWith(status: '1', checkedBy: '1');
          }

          return request;
        }).toList();
      }
      init();
      unsetWidgetBusy('$requestId-request');
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onDecline(String requestId) async {
    try {
      final isConfirm = await dialog.showDialog(DialogRequest(
          title: "Are you sure you want to Decline request?",
          type: DialogType.confirmation));
      if (isConfirm?.result != null) {
        setWidgetBusy('$requestId-request');
        await _leaveService.actionOnLeaveRequest(
            requestId: requestId, action: "2");

        // update correction status of review from reviews where id == attendanceId
        _requests = _requests.map((request) {
          if (request.id == requestId) {
            return request.copyWith(status: '0', checkedBy: '0');
          }

          return request;
        }).toList();
      }
      unsetWidgetBusy('$requestId-request');

      init();
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
