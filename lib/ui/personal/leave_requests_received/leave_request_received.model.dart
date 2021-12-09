import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/services/leave.service.dart';

class LeaveRequestReceivedModel extends ViewModel with SnackbarMixin {
  // Services
  final LeaveService _leaveService = locator<LeaveService>();

  // Data
  List<LeaveRequestData> _requests = [];
  List<LeaveRequestData> get requests => _requests;

  // Action
  Future<void> init() async {
    try {
      setLoading();
      _requests = await _leaveService.getAllLeaveRequests(false);
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onApprove(String requestId) async {
    try {
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
      unsetWidgetBusy('$requestId-request');
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onDecline(String requestId) async {
    try {
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
      unsetWidgetBusy('$requestId-request');
    } catch (e) {
      unsetWidgetBusy('$requestId-request');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
