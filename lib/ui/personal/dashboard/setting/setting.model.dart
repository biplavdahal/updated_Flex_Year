import 'package:bestfriend/di.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import '../../../../data_models/attendance_report.data.dart';
import '../../../../data_models/attendance_report_summary.data.dart';
import '../../../../services/attendance.service.dart';

class SettingModel extends ViewModel with DialogMixin, SnackbarMixin {
  final AttendanceService _attendanceService = locator<AttendanceService>();

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String formattedStartOfMonth = DateFormat('yyyy-MM-dd')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

  static NepaliDateTime nepaliStartOfMonth =
      NepaliDateTime(NepaliDateTime.now().year, NepaliDateTime.now().month, 1);
  static DateTime dateTimeStartOfMonth = nepaliStartOfMonth.toDateTime();
  static String formattedStartOfMonths =
      DateFormat('yyyy-MM-dd').format(dateTimeStartOfMonth);

  List<AttendanceReportData> _monthlyReport = [];
  List<AttendanceReportData> get monthlyReport => _monthlyReport;

  List<AttendanceReportSummaryData> _reportSummary = [];
  List<AttendanceReportSummaryData> get reportSummary => _reportSummary;

  late String? WorkingHours =
      _reportSummary.isNotEmpty ? _reportSummary[0].workingHours : '';
  late int? Leave =
      (_reportSummary.isNotEmpty ? _reportSummary[0].leaveTotal : '') as int;
  late int? holidays =
      _reportSummary.isNotEmpty ? _reportSummary[0].offDay : '' as int;
  late int? present =
      _reportSummary.isNotEmpty ? _reportSummary[0].present : '' as int;
  late int? absent =
      _reportSummary.isNotEmpty ? _reportSummary[0].absent : '' as int;

  MyClass() {
    WorkingHours =
        _reportSummary.isNotEmpty ? _reportSummary[0].workingHours : '';
    Leave = (_reportSummary.isNotEmpty ? _reportSummary[0].absent : '') as int?;
    holidays =
        _reportSummary.isNotEmpty ? _reportSummary[0].offDay : '' as int?;
    present =
        _reportSummary.isNotEmpty ? _reportSummary[0].present : '' as int?;
    absent = _reportSummary.isNotEmpty ? _reportSummary[0].absent : '' as int?;
  }

  Future<void> init() async {
    Map<String, dynamic> _searchParams = {};
    _searchParams['date_from'] = formattedStartOfMonths;
    _searchParams['date_to'] = formattedDate;
    _monthlyReport = await _attendanceService.getMonthlyReport(
      data: _searchParams,
    );
    _reportSummary =
        await _attendanceService.getMonthlySummary(data: _searchParams);
    _searchParams['date_from'] = formattedStartOfMonths;
    _searchParams['date_to'] = formattedDate;
    _monthlyReport = await _attendanceService.getMonthlyReport(
      data: _searchParams,
    );

    print('agsdasfgcdvadas ===' + monthlyReport.length.toString());
  }
}
