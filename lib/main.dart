import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bestfriend/di.dart';
import 'package:bestfriend/services/api.service.dart';
import 'package:bestfriend/services/shared_preference.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/app.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/di.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('sender_id')) {
    AwesomeNotifications()
        .initialize('assets/images/flex_year_login_image.png', [
      NotificationChannel(
          channelKey: 'message',
          channelName: 'Incoming Messages',
          channelDescription:
              "This channel contains all of the notifications related to incoming messages.",
          playSound: true,
          enableLights: true,
          enableVibration: true)
    ]);

    await AwesomeNotifications().cancelAll();

    Map<String, String> payload = {
      "sender_name": message.data["full_name"],
      "sender_id": message.data["sender_id"],
    };

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'message',
            title: message.data["full_name"],
            body: message.notification!.body!, 
            payload: payload));
  }

  debugPrint("Handling a background message: ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await setupLocator();
  await locator<SharedPreferenceService>()();

  locator<ApiService>()(
    baseUrl: auApiBaseUrl,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
