import 'package:bestfriend/di.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';

import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import '../../../../data_models/attendance_report.data.dart';
import '../../../../data_models/attendance_report_summary.data.dart';
import '../../../../services/attendance.service.dart';

class CalanderModel extends ViewModel with DialogMixin, SnackbarMixin {
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
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

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

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  set selectedday(DateTime value) {
    _selectedDay = value;
    setIdle();
  }

  DateTime? _focusedDay;
  DateTime get focusedDay => _focusedDay ?? DateTime.now();
  set focusedday(DateTime value) {
    _focusedDay = value;
    setIdle();
  }

  void onDateSelected(DateTime day, DateTime focusedday) {
    _selectedDay = day;
    _focusedDay = day;

    setIdle();
    notifyListeners();
  }
}
