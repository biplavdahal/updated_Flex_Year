import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/ui/attendance_report/attendance_report.arguments.dart';
import 'package:flex_year_tablet/ui/attendance_report/attendance_report.view.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.arguments.dart';

enum AttendanceReportFilterType {
  daily,
  weekly,
  monthly,
}

class AttendanceReportFilterModel extends ViewModel {
  // Data
  late AttendanceReportFilterType _filterType;
  AttendanceReportFilterType? get filterType => _filterType;

  List<ClientData> get clients =>
      locator<AuthenticationService>().user!.clients;
  List<String> get clientsLabel => clients.map((e) => e.name).toList();

  late ClientData _selectedClient;
  late String _selectedClientLabel;
  String get selectedClientLabel => _selectedClientLabel;

  set selectedClientLabel(String value) {
    _selectedClientLabel = value;
    _selectedClient = clients.firstWhere((e) => e.name == value);
    setIdle();
  }

  List<String> get attendanceTypes => ["All", "Present", "Absent"];
  late String _selectedAttendanceType;
  String get selectedAttendanceType => _selectedAttendanceType;
  set selectedAttendanceType(String value) {
    _selectedAttendanceType = value;
    setIdle();
  }

  List<String> get months => [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      ];
  late String _selectedMonth;
  String get selectedMonth => _selectedMonth;
  set selectedMonth(String value) {
    _selectedMonth = value;
    setIdle();
  }

  DateTime? _attendanceDate;
  DateTime? get attendanceDate => _attendanceDate;
  set attendanceDate(DateTime? value) {
    _attendanceDate = value;
    setIdle();
  }

  DateTime? _weekFrom;
  DateTime? get weekFrom => _weekFrom;
  DateTime? _weekTo;
  DateTime? get weekTo => _weekTo;
  set weekFrom(DateTime? value) {
    _weekFrom = value;
    _weekTo = _weekFrom?.add(const Duration(days: 6));
    setIdle();
  }

  bool _returnBack = false;

  // Actions
  void init(AttendanceReportFilterArguments arguments) {
    _filterType = arguments.type;
    _returnBack = arguments.returnBack;
    if (clients.isNotEmpty) {
      _selectedClient = clients.first;
      _selectedClientLabel = _selectedClient.name;
    }
    _selectedAttendanceType = attendanceTypes.first;

    if (_filterType == AttendanceReportFilterType.monthly) {
      _selectedMonth = months[DateTime.now().month - 1];
    }

    if (_filterType == AttendanceReportFilterType.daily) {
      _attendanceDate = DateTime.now();
    }

    setIdle();
  }

  void onViewReportPressed() {
    Map<String, dynamic> _searchParams = {};

    if (_filterType == AttendanceReportFilterType.monthly) {
      _searchParams['date_from'] =
          "${DateTime.now().year}-${(months.indexOf(_selectedMonth) + 1).toString().length == 1 ? '0${months.indexOf(_selectedMonth) + 1}' : months.indexOf(_selectedMonth) + 1}-01";
      _searchParams['date_to'] =
          lastDateOfMonth(months.indexOf(_selectedMonth) + 1);
    } else if (_filterType == AttendanceReportFilterType.daily) {
      _searchParams['date'] =
          '${_attendanceDate!.year}-${_attendanceDate!.month < 10 ? '0${_attendanceDate!.month}' : _attendanceDate!.month}-${_attendanceDate!.day < 10 ? '0${_attendanceDate!.day}' : _attendanceDate!.day}';
    } else {
      _searchParams['begDate'] =
          '${_weekFrom!.year}-${_weekFrom!.month < 10 ? '0${_weekFrom!.month}' : _weekFrom!.month}-${_weekFrom!.day < 10 ? '0${_weekFrom!.day}' : _weekFrom!.day}';
      _searchParams['endDate'] =
          '${_weekTo!.year}-${_weekTo!.month < 10 ? '0${_weekTo!.month}' : _weekTo!.month}-${_weekTo!.day < 10 ? '0${_weekTo!.day}' : _weekTo!.day}';
    }

    if (clients.isNotEmpty) {
      _searchParams['client_id'] = _selectedClient.clientId;
      _searchParams['client_name'] = _selectedClientLabel;
    }

    _searchParams['type'] = _selectedAttendanceType;
    if (_returnBack) {
      goBack(
        result: AttendanceReportArguments(
          type: _filterType,
          searchParams: _searchParams,
        ),
      );
    } else {
      gotoAndPop(
        AttendanceReportView.tag,
        arguments: AttendanceReportArguments(
          type: _filterType,
          searchParams: _searchParams,
        ),
      );
    }
  }
}
