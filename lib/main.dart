import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bestfriend/bestfriend.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/app.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'channel1',
      title: message.notification?.title,
      body: message.notification?.body,
    ),
  );
  if (message.data.containsKey('access_token')) {
    AwesomeNotifications()
        .initialize('assets/images/flex_year_login_image.png', [
      NotificationChannel(
          channelKey: 'Notification',
          channelName: 'notification',
          channelDescription: "You have successfully login FlexYear",
          playSound: true,
          enableLights: true,
          enableVibration: true)
    ]);
    await AwesomeNotifications().cancelAll();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'flex year',
        title: "you have successfully login",
        body: 'test',
      ),
    );
  }
  debugPrint("--------------haldling a backgroung message----------- ");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await setupLocator();
  await locator<SharedPreferenceService>()();

  locator<ApiService>()(
    baseUrl: auApiBaseUrl,
  );

  await locator<SharedPreferenceService>()();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const FlexYearApp(),
    ),
  );
}
