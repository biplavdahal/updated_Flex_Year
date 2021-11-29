import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/attendance_report.data.dart';
import 'package:flex_year_tablet/data_models/attendance_status.data.dart';
import 'package:flex_year_tablet/data_models/attendance_summary.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flutter/material.dart';

class AttendanceServiceImpl implements AttendanceService {
  final ApiService _apiService = locator<ApiService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();

  @override
  Future<AttendanceStatusData> getAttendanceStatus({
    String? clientId,
  }) async {
    try {
      final _response = await _apiService.get(auAttendanceStatus, params: {
        'access_token': _authenticationService.user!.accessToken,
        'id': _authenticationService.user!.id,
        'company_id': _appAccessService.appAccess!.company.companyId,
        if (clientId != null) 'client_id': clientId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["data"] ?? data["detail"];
      }

      return AttendanceStatusData.fromJson(data);
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<AttendanceForgotData?> getAttendanceForgot() async {
    try {
      final _response = await _apiService.get(auAttendanceForgot, params: {
        'access_token': _authenticationService.user!.accessToken,
        'id': _authenticationService.user!.id,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data[0]);

      debugPrint(data.toString());

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["data"] ?? data["detail"];
      }

      return AttendanceForgotData.fromJson({
        ...data,
        'attendance_id': data['model']['attendance_id'],
      });
    } catch (e) {
      throw apiError(e);
    }
  }

  // FIXME: Need to fix this API
  @override
  Future<AttendanceStatusData> postAttendanceStatus({
    required String time,
    String? clientId,
    required String status,
  }) async {
    try {
      debugPrint(time);

      final _response = await _apiService.post(auAttendanceInOut, {}, params: {
        'access_token': _authenticationService.user!.accessToken,
        'id': _authenticationService.user!.id,
        'company_id': _appAccessService.appAccess!.company.companyId,
        if (clientId != null) 'client_id': clientId,
        'type': status,
        'datetime': time,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return AttendanceStatusData.fromJson(data["data"]["data"]);
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<List<AttendanceReportData>> getMonthlyReport(
      {required Map<String, dynamic> data}) async {
    try {
      final _response = await _apiService.post(
        auMonthlyAttendanceReport,
        {
          ...data,
          'user': [_authenticationService.user!.id],
          'company_id': _appAccessService.appAccess!.company.companyId,
        },
        params: {
          'access_token': _authenticationService.user!.accessToken,
        },
      );

      final _data = constructResponse(_response.data);

      if (_data!.containsKey("status") && _data["status"] == false) {
        throw _data["response"] ?? _data["data"] ?? _data["detail"];
      }

      return _data['data']['att_data'][0]['attendance']
          .map<AttendanceReportData>(
            (e) => AttendanceReportData.fromJson(e),
          )
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }

  // FIXME: Need to fix this API
  @override
  Future<List<AttendanceSummaryData>> getAttendanceSummary(
      {required String date, String? clientId}) async {
    try {
      final _response = await _apiService.get(auAttendanceSummary, params: {
        'date': date,
        'access_token': _authenticationService.user!.accessToken,
        'client_id': clientId,
        'id': _authenticationService.user!.staff.staffId,
      });

      if (_response.data is String) {
        throw 'Something went wrong!';
      }

      final _data = constructResponse(_response.data);

      if (_data!.containsKey("status") && _data["status"] == false) {
        throw _data["response"] ?? _data["detail"] ?? _data["data"];
      }

      return (_response.data as List)
          .map<AttendanceSummaryData>(
            (e) => AttendanceSummaryData.fromJson(e),
          )
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }
}
