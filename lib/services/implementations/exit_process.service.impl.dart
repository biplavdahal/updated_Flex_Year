import 'package:bestfriend/di.dart';
import 'package:bestfriend/services/api.service.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/user_cleareance_data.dart';
import 'package:flex_year_tablet/data_models/user_exit_survey.data.dart';
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
      final _response = await _apiService.get(auStaffGetResign, params: {
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

  @override
  Future<void> createResignRequest(Map<String, dynamic> resignData) async {
    try {
      final _response = await _apiService.post(auStaffPostResign, {
        ...resignData,
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'staff_id': _authenticationService.user!.id,
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
  Future<List<Clearancedata>> getClearanceDetail() async {
    try {
      final _response = await _apiService.post(auStaffGetClearance, {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'limit': 10,
        'page': 1,
        'sortnane': "",
        'sortno': 1,
        'search': {'staff_id': _authenticationService.user!.id}
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return data["data"]
          .map<Clearancedata>((item) => Clearancedata.fromJson(item))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<List<ExitSurveyData>> getQuestions() async {
    try {
      final _response = await _apiService.get(auStaffGetQuestion, params: {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"] ?? data["detail"] ?? data["data"];
      }

      return data["data"]
          .map<ExitSurveyData>((item) => ExitSurveyData.fromJson(item))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> updateResignRequest(Map<String, dynamic> resignData) async {
    try {
      final _response = await _apiService.post(auStaffEditResign, {
        ...resignData,
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'staff_id': _authenticationService.user!.id,
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
  Future<void> submitAnswer(
      {required String questionID,
      required String optionOne,
      required String optionTwo,
      required String optionThree,
      required String optionFour}) async {
    try {
      final _response = await _apiService.post(auStaffPostAnswer, {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'staff_id': _authenticationService.user!.id,
        'survey': [
          {
            "question_id": questionID,
            "option_1": optionOne,
            "option_2": optionTwo,
            "option_3": optionThree,
            "option_4": optionFour
          }
        ]
      });
      constructResponse(_response.data);
      return;
    } catch (e) {
      throw apiError(e);
    }
  }
}
