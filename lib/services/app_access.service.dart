import 'package:flex_year_tablet/data_models/app_access.data.dart';

abstract class AppAccessService {
  AppAccessData? get appAccess;

  Future<void> init();

  Future<void> getApAccess(String token);
}
