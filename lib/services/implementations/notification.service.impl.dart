import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bestfriend/di.dart';
import 'package:bestfriend/services/api.service.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/notice.data.dart';
import 'package:flex_year_tablet/data_models/staff_birthday.data.dart';
import 'package:flex_year_tablet/data_models/staff_performance.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/dio_helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/notification.service.dart';
import 'package:flutter/material.dart';

import '../../data_models/staff_performance_allreport.dart';
import '../authentication.service.dart';

class NotificationServiceImplementation implements NotificationService {
  //Properties
  NoticeData? _notice;
  @override
  NoticeData? get notice => _notice;

  // External depedencies
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final ApiService _apiService = locator<ApiService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  // @override
  // Future<bool> getPermission() async {
  //   if (Platform.isIOS) {
  //     NotificationSettings settings =
  //         await _firebaseMessaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,
  //     );

  //     return (settings.authorizationStatus == AuthorizationStatus.authorized ||
  //         settings.authorizationStatus == AuthorizationStatus.provisional);
  //   }

  //   bool localNotificationAllowed =
  //       await AwesomeNotifications().isNotificationAllowed();

  //   if (!localNotificationAllowed) {
  //     localNotificationAllowed =
  //         await AwesomeNotifications().requestPermissionToSendNotifications();
  //   }

  //   return localNotificationAllowed;
  // }

  // @override
  // Future<RemoteMessage?> getInitialMessage() {
  //   return _firebaseMessaging.getInitialMessage();
  // }

  @override
  void initializeLocalNotification() async {
    AwesomeNotifications().initialize(
      'resource://drawable/ic_notification_logo', // icon for your app notification
      [
        NotificationChannel(
          channelKey: 'channel1',
          channelName: 'FlexYear',
          channelDescription:
              "This channel contains all of the foreground notifications.",
          playSound: true,
          enableLights: true,
          enableVibration: true,
        ),
      ],
    );
  }

  // @override
  // Stream<RemoteMessage> onMessageOpenedApp() {
  //   return FirebaseMessaging.onMessageOpenedApp;
  // }

  // @override
  // Stream<RemoteMessage> onNotificationArrive() {
  //   return FirebaseMessaging.onMessage;
  // }

  @override
  Future<void> showNotification(
      {String? title, String? body, String? payload}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'channel1',
        title: title,
        body: body,
      ),
    );
  }

  @override
  Future<void> cancelNotification([String? key]) async {
    await AwesomeNotifications().cancelAll();
  }

  @override
  Future<void> fetchNotices() async {
    try {
      final _response = await _apiService.get(auStaffDashboard, params: {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId
      });
      final data = constructResponse(_response.data);

      debugPrint(data.toString());

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }
      _notice = NoticeData.fromJson(data);
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<bool> getPermission() {
    throw UnimplementedError();
  }

  @override
  Future<List<StaffBirthdayData>> getStaffBirthday() async {
    try {
      final _response = await _apiService.get(auStaffBirthday, params: {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId
      });

      final _data = constructResponse(_response.data);

      if (_data!.containsKey("status") && _data["status"] == false) {
        throw _data["response"] ?? _data["data"] ?? _data["detail"];
      }
      return (_data['today_birthday'] as List<dynamic>)
          .map<StaffBirthdayData>(
            (e) => StaffBirthdayData.fromJson(e),
          )
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<List<StaffPerformanceAllReportData>> getStaffPerformance() async {
    try {
      final _response = await _apiService.get(auStaffPerformance, params: {
        'access_token': _authenticationService.user!.accessToken,
        'id': _authenticationService.user!.id,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'date_format': 'Nepali'
      });
      final data = constructResponse(_response.data);
      debugPrint(data.toString());

      if (data!.containsKey("status") && data["status"] == false) {
        throw data["response"];
      }

      final reportList = data['data']['all_report'] as List;
      return reportList
          .map<StaffPerformanceAllReportData>(
              (e) => StaffPerformanceAllReportData.fromJson(e['model']))
          .toList();
    } catch (e) {
      throw apiError(e);
    }
  }
}
