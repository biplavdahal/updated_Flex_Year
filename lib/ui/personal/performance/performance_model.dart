import 'package:bestfriend/bestfriend.dart';

import '../../../data_models/company_logo.data.dart';
import '../../../data_models/staff.data.dart';
import '../../../services/app_access.service.dart';
import '../../../services/authentication.service.dart';

class PerformanceModel extends ViewModel {
  //Data
  CompanyLogoData get logo => locator<AppAccessService>().appAccess!.logo;

  //Action
  Future<void> init() async {}
}
