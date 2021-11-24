import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/services/leave.service.dart';

class LeaveRequestModel extends ViewModel with SnackbarMixin {
  // Service
  final LeaveService _leaveService = locator<LeaveService>();

  // Data
  List<String> get tabs => [
        'Pending',
        'Approved',
        'Rejected',
      ];

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
}
