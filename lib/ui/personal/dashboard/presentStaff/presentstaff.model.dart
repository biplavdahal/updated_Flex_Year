import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';

import '../../../../data_models/present_staff.data.dart';

class PresentStaffModel extends ViewModel with SnackbarMixin, DialogMixin {
  //Service
  final _attendanceService = locator<AttendanceService>();

  //Data
  List<String> get tabs => [
        'Check In',
        'Check Out',
      ];
  String _selectedTab = '0';
  String get selectedTab => _selectedTab;

  set selectedTab(String tab) {
    _selectedTab = tab;
    setIdle();
  }

  List<PresentStaffModelData> _presentstaffs = [];
  final _status = {"Check In": "0", "Check Out": "1"};
  List<PresentStaffModelData> get filteredList => _presentstaffs
      .where((request) => _status[request.status] == _selectedTab)
      .toList();
  List<PresentStaffModelData> get presentStaff =>
      _attendanceService.presentStaff;

  //Action
  Future<void> init() async {
    try {
      setLoading();
      _presentstaffs = await _attendanceService.getPresentstaffs();
      _attendanceService.presentStaff = _presentstaffs;
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
