import 'dart:async';

import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/company.data.dart';
import 'package:flex_year_tablet/data_models/company_logo.data.dart';
import 'package:flex_year_tablet/data_models/user.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';

class DashboardModel extends ViewModel with DialogMixin, SnackbarMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();

  // Data
  CompanyData get company => locator<AppAccessService>().appAccess!.company;
  CompanyLogoData get logo => locator<AppAccessService>().appAccess!.logo;
  UserData get user => locator<AuthenticationService>().user!;

  String _currentDateTime = DateTime.now().toString();
  String get currentDateTime => _currentDateTime;

  Timer? _currentDateTimeTimer;

  late AttendanceStatusData _attendanceStatus;
  AttendanceStatusData get attendanceStatus => _attendanceStatus;

  AttendanceForgotData? _attendanceForgot;
  AttendanceForgotData? get attendanceForgot => _attendanceForgot;

  List<String>? _clientLabels;
  List<String>? get clientLabels => _clientLabels;

  ClientData? _selectedClient;
  ClientData? get selectedClient => _selectedClient;

  String? _selectedClientLabel;
  String? get selectedClientLabel => _selectedClientLabel;

  // Actions
  Future<void> init() async {
    _attendanceForgot = null;

    _currentDateTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDateTime = DateTime.now().toString();
      setIdle();
    });

    _clientLabels = [];

    for (var client in user.clients) {
      _clientLabels?.add(client.name);
    }

    if (_clientLabels!.isNotEmpty) {
      _selectedClientLabel = _clientLabels!.first;
      _selectedClient = user.clients.first;
    }

    setWidgetBusy('todays-attendance');

    _attendanceService
        .getAttendanceStatus(
            clientId:
                _selectedClient != null ? _selectedClient!.clientId : null)
        .then((status) {
      _attendanceStatus = status;
      unsetWidgetBusy("todays-attendance");
    }).catchError((e) {
      unsetWidgetBusy("todays-attendance");
      unsetWidgetBusy('dashboard');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    });

    _attendanceService.getAttendanceForgot().then((status) {
      if (status != null) {
        _attendanceForgot = status;
        setIdle();
      }
    }).catchError((e) {
      // snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    });
  }

  Future<void> logout() async {
    try {
      dialog.showDialog(
        DialogRequest(
          type: DialogType.progress,
          title: "Logging you out...",
        ),
      );
      await locator<AuthenticationService>().logout();
      _currentDateTimeTimer?.cancel();
      dialog.hideDialog();
      gotoAndClear(LoginView.tag);
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  Future<void> onClientChanged(String? label) async {
    if (_clientLabels != null && _clientLabels!.isNotEmpty) {
      if (label == null) {
        return;
      }

      if (_selectedClientLabel == label) {
        return;
      }

      _selectedClientLabel = label;
      _selectedClient =
          user.clients.firstWhere((client) => client.name == label);

      setWidgetBusy('todays-attendance');
      _attendanceService
          .getAttendanceStatus(clientId: _selectedClient!.clientId)
          .then((status) {
        _attendanceStatus = status;
        unsetWidgetBusy("todays-attendance");
      }).catchError((e) {
        unsetWidgetBusy("todays-attendance");
        unsetWidgetBusy('dashboard');
        snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
      });

      setIdle();
    }
  }

  Future<void> onAttendanceButtonPressed(String status) async {
    try {
      dialog.showDialog(
        DialogRequest(
            type: DialogType.progress, title: "Action in progress..."),
      );

      _attendanceStatus = await _attendanceService.postAttendanceStatus(
        clientId: _selectedClient != null ? _selectedClient!.clientId : null,
        status: status,
        time: _attendanceForgot == null
            ? getCurrentDateTime()
            : _attendanceForgot!.forgottonDate,
      );

      dialog.hideDialog();
      setIdle();
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
