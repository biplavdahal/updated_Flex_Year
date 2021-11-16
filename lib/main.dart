import 'dart:async';

import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/app.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  await locator<SharedPreferenceService>()();

  locator<ApiService>()(
    baseUrl: auBaseURL,
  );
  runApp(const FlexyearTabletApp());
}
