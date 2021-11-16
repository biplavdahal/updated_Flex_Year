import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/start_up/start_up.model.dart';

Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceServiceImplementation());
  locator.registerLazySingleton<ApiService>(() => ApiServiceImplementation());
  locator.registerLazySingleton<NavigationService>(
      () => NavigationServiceImplementation());

  // Killable models
  locator.registerFactory(() => StartUpModel());

  // Unkillable models
}
