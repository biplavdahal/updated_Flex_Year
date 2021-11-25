import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/company.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
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

  List<String> get attendanceTypes => ["Present", "Absent", "All"];
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

  // Actions
  void init(AttendanceReportFilterArguments arguments) {
    _filterType = arguments.type;
    _selectedClient = clients.first;
    _selectedClientLabel = _selectedClient.name;
    _selectedAttendanceType = attendanceTypes.first;

    if (_filterType == AttendanceReportFilterType.monthly) {
      _selectedMonth = months[DateTime.now().month - 1];
    }

    if (_filterType == AttendanceReportFilterType.daily) {
      _attendanceDate = DateTime.now();
    }

    setIdle();
  }
}
