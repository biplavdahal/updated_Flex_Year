import 'package:bestfriend/di.dart';
import 'package:bestfriend/services/api.service.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/dio_helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/exit_process.service.dart';

class ExitProcessImpl implements ExitProcess {
  final ApiService _apiService = locator<ApiService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Future<List<ResignData>> getResignData() async {
    try {
      final _response = await _apiService.post(auStaffGetResign, {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'staff_id': _authenticationService.user!.id,
      });

      final data = constructResponse(_response.data);
      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }
      return data["data"]
          .map<ResignData>((item) => ResignData.fromJson(item))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }
}
