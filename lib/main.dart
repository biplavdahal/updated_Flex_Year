import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bestfriend/bestfriend.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flex_year_tablet/app.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/di.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  // await FireBaseAPI().initNotifications();

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // await messaging.requestPermission();

  // AwesomeNotifications()
  //     .initialize('assets/images/ic_launcher_adaptive_fore.png', [
  //   NotificationChannel(
  //     channelKey: 'my_channel',
  //     channelName: 'channel',
  //     channelDescription: '',
  //     importance: NotificationImportance.High,
  //     defaultColor: AppColor.primary,
  //     playSound: true,
  //     enableVibration: true,
  //   )
  // ]);

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //   final Map<String, dynamic> data = message.data;
  //   if (data.isNotEmpty) {
  //     print(' -------------******** Custom data: $data *********--------- ');

  //     final String customTitle = data['title'] ?? 'Notification Title';
  //     final String customBody = data['body'] ?? 'Notification Body';

  //     await AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //         id: 10,
  //         channelKey: 'my_channel',
  //         title: customTitle,
  //         body: customBody,
  //       ),
  //     );
  //   }
  // });

  await setupLocator();
  await locator<SharedPreferenceService>()();

  locator<ApiService>()(
    baseUrl: auApiBaseUrl,
  );

  await locator<SharedPreferenceService>()();

  runApp(const FlexYearApp());
}

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

class FireBaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
  }
}
