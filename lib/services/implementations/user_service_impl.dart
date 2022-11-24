import 'package:bestfriend/bestfriend.dart';
import 'package:dio/dio.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/user_service.dart';


import '../../helper/api_error.helper.dart';
import '../../helper/api_response.helper.dart';

class UserServiceImplementation implements UserService {
  //services
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ApiService _apiService = locator<ApiService>();

  @override
  Future<void> changePassword(String password) async{
    try{
      final response = await _apiService.post(auChangePassword, {}, params:{
        "access_token": _authenticationService.user!.accessToken,
        "user_id": _authenticationService.user!.id,
        "old_password": password,
        "confirm_password" : password,
        "password": password
      });
      final data = constructResponse(response.data);
      if(data!["status"] is bool){
        if(data["status"]){
          return;
        }
      }
    } catch (e) {
      throw apiError(e);
    }
    
  }

  @override
  Future<void> updateProfile(StaffData data) async {
    try {
      final response = await _apiService.post(auUpdateProfile, {
        "access_token": _authenticationService.user!.accessToken,
        "id": _authenticationService.user!.id,
        "staff_photo": _authenticationService.user!.staffPhoto,
        ...data.toJson(),
      });

      final responseData = constructResponse(response.data);

      if (responseData!["status"] is bool) {
        if (responseData["status"]) {
          _authenticationService.updateUser(responseData["response"]);
          return;
        }
      }

      
    } on DioError catch (e) {
      throw apiError(e);
    }
  }
}
