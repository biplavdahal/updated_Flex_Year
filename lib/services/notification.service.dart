// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/data_models/notice.data.dart';

import '../data_models/staff_birthday.data.dart';

abstract class NotificationService {
  /// Initializes local notification channels
  void initializeLocalNotification();

  /// Get permission [Apple/Web]
  Future<bool> getPermission();

  // /// Listen to foreground notification
  // Stream<RemoteMessage> onNotificationArrive();

  // /// Listens to notification that was clicked to open app
  // Stream<RemoteMessage> onMessageOpenedApp();

  // /// Gets initial notification
  // Future<RemoteMessage?> getInitialMessage();

  /// Notify locally
  Future<void> showNotification({String? title, String? body, String? payload});

  /// Cancel all notifications
  Future<void> cancelNotification([String? key]);

  /// --------- The notice API model is also implemented inside this class ----------

  // Fetch notice from /site/staffdashboard API

  NoticeData? get notice;

  Future<void> fetchNotices();

  //staff birthday
  Future<List<StaffBirthdayData>> getStaffBirthday();
}
