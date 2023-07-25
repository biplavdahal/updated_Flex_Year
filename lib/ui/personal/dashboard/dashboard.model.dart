import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/company.data.dart';
import 'package:flex_year_tablet/data_models/company_logo.data.dart';
import 'package:flex_year_tablet/data_models/notice.data.dart';
import 'package:flex_year_tablet/data_models/user.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/notification.service.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.view.dart';
import 'package:flex_year_tablet/ui/personal/date_converter/date_converter.view.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/personal/login/login.view.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import '../../../data_models/attendance_report.data.dart';
import '../../../data_models/attendance_report_summary.data.dart';
import '../attendance_correction/attendance_correction.view.dart';
import '../change_password/change_password_view.dart';
import '../edit_profile/edit_profile.view.dart';

class DashboardModel extends ViewModel with DialogMixin, SnackbarMixin {
  // Services
  final AttendanceService _attendanceService = locator<AttendanceService>();
  final NotificationService _notificationService =
      locator<NotificationService>();

  // Data
  CompanyData get company => locator<AppAccessService>().appAccess!.company;
  CompanyLogoData get logo => locator<AppAccessService>().appAccess!.logo;
  UserData get user => locator<AuthenticationService>().user!;
  NoticeData get notice => locator<NotificationService>().notice!;

  String _currentDateTime = DateTime.now().toString();
  String get currentDateTime => _currentDateTime;

  Timer? _currentDateTimeTimer;

  AttendanceStatusData? _attendanceStatus;
  AttendanceStatusData? get attendanceStatus => _attendanceStatus;

  List<AttendanceCorrectionData> _attendanceCorrectionData = [];
  List<AttendanceCorrectionData> get attendanceCorrectionData =>
      _attendanceCorrectionData;

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

  AttendanceSummaryData? _attendanceData;
  AttendanceSummaryData? get attendanceData => _attendanceData;

  AttendanceForgotData? _attendanceForgot;
  AttendanceForgotData? get attendanceForgot => _attendanceForgot;

  List<String>? _clientLabels;
  List<String>? get clientLabels => _clientLabels;

  ClientData? _selectedClient;
  ClientData? get selectedClient => _selectedClient;

  String? _selectedClientLabel;
  String? get selectedClientLabel => _selectedClientLabel;

  // UI Controllers
  int _currentFragment = 2;
  int get currentFragment => _currentFragment;
  set currentFragment(int value) {
    _currentFragment = value;
    setIdle();

    if (value == 0) {
      locator<DashboardModel>().goto(AttendanceCorrectionView.tag);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        currentFragment = 2;
      });
    }
    if (value == 1) {
      locator<DashboardModel>().goto(LeaveRequestView.tag);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        currentFragment = 2;
      });
    }
    if (value == 2) {
      locator<DashboardModel>().goto(DashboardView.tag);
      goBack();
    }
    if (value == 3) {
      locator<DashboardModel>().goto(DateConverterView.tag);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        currentFragment = 2;
      });
    }
    if (value == 4) {
      locator<DashboardModel>().goto(ProfileView.tag);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        currentFragment = 2;
      });
    }
  }

  // Actions
  Future<void> init() async {
    _attendanceForgot = null;
    _attendanceService.getAttendanceForgot().then((status) {
      if (status != null) {
        _attendanceForgot = status;
        setIdle();
      }
    }).catchError((e) {
      // snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    });
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
    HolidaysModel.holidaydata();

    _currentDateTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDateTime = DateTime.now().toString();
      setIdle();
    });

    _clientLabels = [];
    _attendanceCorrectionData =
        (await _attendanceService.getAttendanceCorrections(
            dateTime: formattedDate =
                DateFormat('yyyy-MM-dd ').format(DateTime.now())));

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
            clientId: _selectedClient != null
                ? _selectedClient!.clientId.toString()
                : null)
        .then((status) {
      _attendanceStatus = status;
      unsetWidgetBusy("todays-attendance");
    }).catchError((e) {
      unsetWidgetBusy("todays-attendance");
      unsetWidgetBusy('dashboard');
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    });

    try {
      HolidaysModel.holidaydata();

      _notificationService.fetchNotices();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final isConfirm = await dialog.showDialog(DialogRequest(
        type: DialogType.confirmation,
        title: "Are you sure you want to logout?",
        dismissable: true,
      ));
      if (isConfirm?.result != null) {
        dialog.showDialog(DialogRequest(
            type: DialogType.progress, title: "Logging you out..."));
        await locator<AuthenticationService>().logout();
        _currentDateTimeTimer?.cancel();
        dialog.hideDialog();
        gotoAndClear(LoginView.tag);
      }
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
          .getAttendanceStatus(clientId: _selectedClient!.clientId.toString())
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

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String formattedStartOfMonth = DateFormat('yyyy-MM-dd')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

  static NepaliDateTime nepaliStartOfMonth =
      NepaliDateTime(NepaliDateTime.now().year, NepaliDateTime.now().month, 1);
  static DateTime dateTimeStartOfMonth = nepaliStartOfMonth.toDateTime();
  static String formattedStartOfMonths =
      DateFormat('yyyy-MM-dd').format(dateTimeStartOfMonth);

  Future<void> onAttendanceButtonPressed(String status) async {
    try {
      dialog.showDialog(
        DialogRequest(
            type: DialogType.progress, title: "Action in progress..."),
      );

      _attendanceStatus = await _attendanceService.postAttendanceStatus(
        clientId: _selectedClient != null
            ? _selectedClient!.clientId.toString()
            : null,
        status: status,
        time: _attendanceForgot == null
            ? getCurrentDateTime()
            : _attendanceForgot!.forgottonDate,
      );

      dialog.hideDialog();
      init();
      setIdle();
      if (status == 'checkin') {
        Fluttertoast.showToast(
            msg: 'You have successfully checkin',
            backgroundColor: Colors.green);
      } else if (status == 'checkout') {
        Fluttertoast.showToast(
            msg: 'You have successfully checkout',
            backgroundColor: Colors.green);
      } else if (status == 'lunchin') {
        Fluttertoast.showToast(
            msg: 'You have Successfully lunchin',
            backgroundColor: Colors.green);
      } else {
        Fluttertoast.showToast(
            msg: 'You have successfully lunchout',
            backgroundColor: Colors.green);
      }
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
    if (attendanceForgot == null) {
      AwesomeNotifications()
          .initialize('resource://drawable/ic_notification_logo', [
        NotificationChannel(
          channelKey: ' flex message',
          channelName: 'Forget Checkout??',
          channelDescription:
              "This channle contail all of the notification related to forget checkout.",
          playSound: true,
          enableLights: true,
          enableVibration: true,
        )
      ]);
    }
  }

  void moreActions(String action) {
    switch (action) {
      case "logout":
        _logout();
    }
  }

  Future<void> _logout() async {
    try {
      final isConfirm = await dialog.showDialog(DialogRequest(
        type: DialogType.confirmation,
        title: "Are you sure you want to logout?",
        dismissable: true,
      ));
      if (isConfirm?.result != null) {
        dialog.showDialog(DialogRequest(
            type: DialogType.progress, title: "Logging you out..."));
        await locator<AuthenticationService>().logout();
        _currentDateTimeTimer?.cancel();
        dialog.hideDialog();
        gotoAndClear(LoginView.tag);
      }
    } catch (e) {
      dialog.hideDialog();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }

  ///ADMIN STUFFS

}
