import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/services/notification.service.dart';

class NotificationServiceImplementation implements NotificationService {
  // External depedencies
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<bool> getPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      return (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional);
    }

    bool localNotificationAllowed =
        await AwesomeNotifications().isNotificationAllowed();

    if (!localNotificationAllowed) {
      localNotificationAllowed =
          await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    return localNotificationAllowed;
  }

  @override
  Future<RemoteMessage?> getInitialMessage() {
    return _firebaseMessaging.getInitialMessage();
  }

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

  @override
  Stream<RemoteMessage> onMessageOpenedApp() {
    return FirebaseMessaging.onMessageOpenedApp;
  }

  @override
  Stream<RemoteMessage> onNotificationArrive() {
    return FirebaseMessaging.onMessage;
  }

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
}
