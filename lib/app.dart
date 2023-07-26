import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.manager.dart';
import 'package:flex_year_tablet/routes.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class FlexYearApp extends StatelessWidget {
  
  const FlexYearApp({Key? key,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(), 
        child: Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
            return MaterialApp(
              supportedLocales: const [
                Locale('en'),
                Locale('ne'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              locale:
                  localeProvider.locale,
              debugShowCheckedModeBanner: false,
              theme: getThemeDataTheme(context),
              onGenerateRoute: (settings) =>
                  locator<NavigationService>().generateRoute(
                settings,
                routesAndViews(settings),
              ),
              builder: (context, child) {
                return Navigator(
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => DialogManager(
                      child: SnackbarManager(
                        behavior: SnackBarBehavior.floating,
                        elevation: 0,
                        infoColor: AppColor.primary,
                        errorColor: Colors.red,
                        successColor: Colors.green,
                        warningColor: AppColor.accent,
                        body: child!,
                      ),
                    ),
                  ),
                );
              },
              navigatorKey: locator<NavigationService>().navigationKey,
              home: const StartUpView(),
            );
          },
        ),
      ),
    );
  }
  // void _changeLocale(Locale newLocale) {
    
  //   final localeProvider = Provider.of<LocaleProvider>(
  //       navigatorKey.currentContext!,
  //       listen: false);
  //   localeProvider.setLocale(newLocale);
  // }
}
