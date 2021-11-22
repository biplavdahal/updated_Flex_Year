import 'dart:convert';

import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/constants/prefs.constants.dart';
import 'package:flex_year_tablet/data_models/app_access.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';

class AppAccessServiceImplementation implements AppAccessService {
  final ApiService _apiService = locator<ApiService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  AppAccessData? _appAccessData;
  @override
  AppAccessData? get appAccess => _appAccessData;

  @override
  Future<void> init() async {
    final appAccessDataStr =
        await _sharedPreferenceService.get<String?>(pfAccessData);

    if (appAccessDataStr.value == null) {
      return;
    }

    _appAccessData = AppAccessData.fromJson(
      jsonDecode(appAccessDataStr.value!),
    );
  }

  @override
  Future<void> getApAccess(String token) async {
    try {
      final _response = await _apiService.get(auAppAccess, params: {
        'token': token,
      });

      final data = constructResponse(_response.data);

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }

      _appAccessData = AppAccessData.fromJson(data);

      await _sharedPreferenceService.set(
        pfAccessData,
        jsonEncode(_appAccessData),
      );
    } catch (e) {
      throw apiError(e);
    }
  }
}
