import 'package:bestfriend/di.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import '../../../../data_models/attendance_report.data.dart';
import '../../../../data_models/company.data.dart';
import '../../../../services/app_access.service.dart';
import '../../../../services/attendance.service.dart';

class CalanderModel extends ViewModel with DialogMixin, SnackbarMixin {
  final AttendanceService _attendanceService = locator<AttendanceService>();

  List<AttendanceReportData> _monthlyReport = [];
  List<AttendanceReportData> get monthlyReport => _monthlyReport;

  CompanyData get company => locator<AppAccessService>().appAccess!.company;

// Get the first day of the current year
  DateTime firstDayOfYear = DateTime(DateTime.now().year, 1, 1);

// Get the last day of the current year
  DateTime lastDayOfYear = DateTime(DateTime.now().year, 12, 31);

  Future<void> init() async {
    //  if (company.companyPreference == 'N') {
    //   NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);
    //   int nepaliMonth = nepaliDateTime.month;

    //   startDate =
    //       NepaliDateTime(nepaliDateTime.year, nepaliMonth, 1).toDateTime();
    //   endDate = NepaliDateTime(nepaliDateTime.year, nepaliMonth + 1, 1)
    //       .toDateTime()
    //       .subtract(const Duration(days: 1));
    // } else {
    //   startDate = DateTime(currentDate.year, currentMonth, 1);

    //   endDate = DateTime(currentDate.year, currentMonth + 1, 0);
    // }

    Map<String, dynamic> _searchParams = {};
    _searchParams['date_from'] = firstDayOfYear.toLocal().toString();
    _searchParams['date_to'] = lastDayOfYear.toLocal().toString();
    _monthlyReport = await _attendanceService.getMonthlyReport(
      data: _searchParams,
    );
  }
}
