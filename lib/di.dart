import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.service.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.service.impl.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/implementations/app_access.service.impl.dart';
import 'package:flex_year_tablet/services/implementations/authentication.service.impl.dart';
import 'package:flex_year_tablet/ui/app_access/app_access.model.dart';
import 'package:flex_year_tablet/ui/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/login/login.model.dart';
import 'package:flex_year_tablet/ui/profile/profile.model.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.model.dart';

Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceServiceImplementation());
  locator.registerLazySingleton<ApiService>(() => ApiServiceImplementation());
  locator.registerLazySingleton<NavigationService>(
      () => NavigationServiceImplementation());
  locator.registerLazySingleton<SnackbarService>(
      () => SnackbarServiceImplementation());
  locator.registerLazySingleton<AppAccessService>(
      () => AppAccessServiceImplementation());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceImpl());
  locator.registerLazySingleton<DialogService>(
      () => DialogServiceImplementation());

  // Killable models
  locator.registerFactory(() => StartUpModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => AppAccessModel());
  locator.registerFactory(() => DashboardModel());
  locator.registerFactory(() => ProfileModel());

  // Unkillable models
}
