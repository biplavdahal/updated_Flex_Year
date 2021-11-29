import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/ui/attendance_report/attendance_report.arguments.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.arguments.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.view.dart';

class AttendanceReportModel extends ViewModel with SnackbarMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  late AttendanceReportFilterType _filterType;
  AttendanceReportFilterType get filterType => _filterType;
  late Map<String, dynamic> _searchParams;
  Map<String, dynamic> get searchParams => _searchParams;

  List<AttendanceReportData> _monthlyReport = [];
  List<AttendanceReportData> get monthlyReport => _monthlyReport;

  List<AttendanceSummaryData> _summary = [];
  List<AttendanceSummaryData> get summary => _summary;

  // Actions
  Future<void> init(AttendanceReportArguments arguments) async {
    _filterType = arguments.type;
    _searchParams = arguments.searchParams;
    setIdle();

    try {
      setLoading();

      if (_filterType == AttendanceReportFilterType.monthly) {
        _monthlyReport = await _attendanceService.getMonthlyReport(
          data: _searchParams,
        );
      } else if (_filterType == AttendanceReportFilterType.daily) {
        _summary = await _attendanceService.getAttendanceSummary(
          date: _searchParams['date'],
          clientId: _searchParams['clientId'],
        );
      }

      setSuccess();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> onFilterPressed() async {
    final response = await goto(
      AttendanceReportFilterView.tag,
      arguments: AttendanceReportFilterArguments(
        type: _filterType,
        returnBack: true,
      ),
    );

    if (response != null) {
      init(response);
    }
  }
}
