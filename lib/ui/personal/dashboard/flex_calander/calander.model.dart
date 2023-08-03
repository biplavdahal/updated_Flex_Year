import 'package:bestfriend/di.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import '../../../../data_models/attendance_report.data.dart';
import '../../../../services/attendance.service.dart';

class CalanderModel extends ViewModel with DialogMixin, SnackbarMixin {
  final AttendanceService _attendanceService = locator<AttendanceService>();

  List<AttendanceReportData> _monthlyReport = [];
  List<AttendanceReportData> get monthlyReport => _monthlyReport;

// Get the first day of the current year
  DateTime firstDayOfYear = DateTime(DateTime.now().year, 1, 1);

// Get the last day of the current year
  DateTime lastDayOfYear = DateTime(DateTime.now().year, 12, 31);

  Future<void> init() async {
    Map<String, dynamic> _searchParams = {};
    _searchParams['date_from'] = firstDayOfYear.toLocal().toString();
    _searchParams['date_to'] = lastDayOfYear.toLocal().toString();
    _monthlyReport = await _attendanceService.getMonthlyReport(
      data: _searchParams,
    );
  }
}
