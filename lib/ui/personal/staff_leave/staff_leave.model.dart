import 'package:bestfriend/di.dart';
import 'package:bestfriend/managers/snack_bar/snack_bar_request.model.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';

import '../../../data_models/leave_request.data.dart';
import '../../../services/leave.service.dart';

class StaffLeavemodel extends ViewModel with SnackbarMixin, DialogMixin {
  //services
  final LeaveService _leaveService = locator<LeaveService>();
  int _limit = 15;

  List<LeaveRequestData> _requests = [];
  List<LeaveRequestData> get requests => _requests;
  List<LeaveRequestData> get requestsToShow =>
      _requests.where((request) => request.status == "1").toList();

  //action
  Future<void> init() async {
    try {
      setLoading();
      _requests = await _leaveService.getAllLeaveRequests(
        limit: _limit,
      );

      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
