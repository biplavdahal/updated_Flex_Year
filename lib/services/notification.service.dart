// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/data_models/notice.data.dart';
import 'package:flex_year_tablet/data_models/notification.data.dart';

import '../data_models/all_staff_birthday.data.dart';
import '../data_models/staff_birthday.data.dart';

import '../data_models/staff_performance_allreport.dart';

abstract class NotificationService {
  /// Initializes local notification channels
  void initializeLocalNotification();

  /// Get permission [Apple/Web]
  Future<bool> getPermission();

  /// Update FCM Token into user's firestore document.
  Future<void> updateFcmToken(String accessToken, int userId);

  /// Listen to foreground notification
  Stream<RemoteMessage> onNotificationArrive();

  /// Listens to notification that was clicked to open app
  Stream<RemoteMessage> onMessageOpenedApp();

  /// Gets initial notification
  Future<RemoteMessage?> getInitialMessage();

  /// Notify locally
  Future<void> showNotification(
      {required String title, required String body, String? payload});

  // Show message notification
  Future<void> showMessageNotification({
    required String senderName,
    required Map<String, dynamic> payload,
  });

  /// Cancel all notifications
  Future<void> cancelNotification([String? key]);

  /// --------- The notice API model is also implemented inside this class ----------

  // Fetch notice from /site/staffdashboard API

  NoticeData? get notice;

  Future<void> fetchNotices();

  //staff birthday
  Future<List<StaffBirthdayData>> getStaffBirthday();

  //staff performance
  Future<List<StaffPerformanceAllReportData>> getStaffPerformance();

  //upcomming Birthday
  Future<List<AllStaffBirthdayData>> getAllStaffBirthday();

  //In app notification
  Future<List<NotificationData>> getAllNotification();
}
