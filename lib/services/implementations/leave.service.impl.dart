import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/leave_request.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/leave.service.dart';

class LeaveServiceImpl implements LeaveService {
  final ApiService _apiService = locator<ApiService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Future<void> createLeaveRequest(Map<String, dynamic> leaveData) async {
    try {
      final _response = await _apiService.post(auNewLeaveRequest, {
        ...leaveData,
        'user_id': _authenticationService.user!.id,
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return;
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<List<LeaveRequestData>> getAllLeaveRequests() async {
    try {
      final _response = await _apiService.post(auLeaveHistory, {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'search': {
          'staff_id': _authenticationService.user!.id,
        }
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return data["data"]
          .map<LeaveRequestData>((item) => LeaveRequestData.fromJson(item))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }
}
