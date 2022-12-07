import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';

class AttendanceCorrectionModel extends ViewModel
    with SnackbarMixin, DialogMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  List<String> get tabs => ['pending', 'Approved', 'Rejected', 'All'];

  String _selectedTab = "0";
  String get selectedTab => _selectedTab;

  set selectedTab(String tab) {
    _selectedTab = tab;
    setIdle();
  }

  List<AttendanceCorrectionData> _corrections = [];
  List<AttendanceCorrectionData> get correctionsToShow => _corrections
      .where((correction) => correction.correctionStatus == _selectedTab)
      .toList();
  List<AttendanceCorrectionData> get corrections => _corrections;

  // Actions
  Future<void> init() async {
    try {
      setLoading();
      _corrections = await _attendanceService.getAttendanceCorrections();
      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onDelete(String _attendanceId) async {
    try {
      final isConfirm = await dialog.showDialog(
        DialogRequest(
            type: DialogType.confirmation,
            title: 'Are you sure you want to delete correction request?'),
      );

      if (isConfirm?.result != null) {
        dialog.showDialog(
          DialogRequest(
              type: DialogType.progress, title: 'Removing correction request.'),
        );

        await _attendanceService.removeAttendanceCorrection(_attendanceId);

        _corrections
            .removeWhere((element) => element.attendanceId == _attendanceId);
        setIdle();

        dialog.hideDialog();
      }
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
