import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationService {
  /// Initializes local notification channels
  void initializeLocalNotification();

  /// Get permission [Apple/Web]
  Future<bool> getPermission();

  /// Listen to foreground notification
  Stream<RemoteMessage> onNotificationArrive();

  /// Listens to notification that was clicked to open app
  Stream<RemoteMessage> onMessageOpenedApp();

  /// Gets initial notification
  Future<RemoteMessage?> getInitialMessage();

  /// Notify locally
  Future<void> showNotification(
      {String? title, String? body, String? payload});

  /// Cancel all notifications
  Future<void> cancelNotification([String? key]);
}
