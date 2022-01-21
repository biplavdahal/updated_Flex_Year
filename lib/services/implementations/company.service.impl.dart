import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/company_staff.data.dart';
import 'package:flex_year_tablet/data_models/holiday.data.dart';
import 'package:flex_year_tablet/data_models/leave_type.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flutter/material.dart';

class CompanyServiceImpl implements CompanyService {
  final ApiService _apiService = locator<ApiService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();

  List<LeaveTypeData>? _leaveTypes;
  @override
  List<LeaveTypeData>? get leaveTypes => _leaveTypes;

  List<ClientData>? _clients;
  @override
  List<ClientData>? get clients => _clients;

  @override
  Future<void> init() async {
    try {
      await _fetchLeaveTypes();
      await _fetchClients();

      debugPrint(_leaveTypes.toString());
    } catch (e) {
      throw apiError(e);
    }
  }

  Future<void> _fetchLeaveTypes() async {
    try {
      final _response = await _apiService.get(auLeaveTypes, params: {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey('status') && data['status'] == false) {
        throw data['response'] ?? data['data'] ?? data['detail'];
      }

      final _typesJson = data['data'] as List;

      _leaveTypes =
          _typesJson.map((json) => LeaveTypeData.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<HolidayData>> getHolidays() async {
    try {
      final _response = await _apiService.get(auHolidays, params: {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      debugPrint(_response.data.toString());

      final data = constructResponse(_response.data);

      if (data!.containsKey('status') && data['status'] == false) {
        throw data['response'] ?? data['detail'] ?? data['data'];
      }

      final _holidaysJson = data['data'] as List;

      return _holidaysJson
          .map((json) => HolidayData.fromJson(json))
          .where(
              (holiday) => DateTime.parse(holiday.date).isAfter(DateTime.now()))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<List<CompanyStaffData>> getStaffs({String? clientId}) async {
    try {
      final _response = await _apiService.get(auStaffsList, params: {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'client_id': clientId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey('status') && data['status'] == false) {
        throw data['response'] ?? data['detail'] ?? data['data'];
      }

      final _staffsJson = data['data'] as List;

      return _staffsJson
          .where((staff) => staff["user_id"] != null)
          .map((json) => CompanyStaffData.fromJson(json))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }

  Future<void> _fetchClients() async {
    try {
      final _response = await _apiService.get(auClients, params: {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data);

      if (data?['data'] is String) {
        // Do nothing
      } else {
        final _clientsJson = data?['data'] as List;

        _clients =
            _clientsJson.map((json) => ClientData.fromJson(json)).toList();
      }
    } catch (e) {
      throw apiError(e);
    }
  }
}
