import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/routes.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.view.dart';
import 'package:flutter/material.dart';

class FlexyearTabletApp extends StatelessWidget {
  const FlexyearTabletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getThemeDataTheme(context),
        onGenerateRoute: (settings) =>
            locator<NavigationService>().generateRoute(
          settings,
          routesAndViews(settings),
        ),
        navigatorKey: locator<NavigationService>().navigationKey,
        home: const StartUpView(),
      ),
    );
  }
}
