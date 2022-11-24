import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/leave.service.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.arguments.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.view.dart';

class LeaveRequestModel extends ViewModel with SnackbarMixin, DialogMixin {
  // Service
  final LeaveService _leaveService = locator<LeaveService>();

  // Data
  List<String> get tabs => ['Pending', 'Approved', 'Rejected', 'All'];

  String _selectedTab = "0";
  String get selectedTab => _selectedTab;

  set selectedTab(String tab) {
    _selectedTab = tab;
    setIdle();
  }

  List<LeaveRequestData> _requests = [];
  List<LeaveRequestData> get requestsToShow =>
      _requests.where((request) => request.status == _selectedTab).toList();

  // Action
  Future<void> init() async {
    try {
      setLoading();

      _requests = await _leaveService.getAllLeaveRequests();

      setIdle();
    } catch (e) {
      setIdle();
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
}
