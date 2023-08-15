import 'package:bestfriend/bestfriend.dart';

import '../../../data_models/company_logo.data.dart';
import '../../../data_models/staff_performance_allreport.dart';
import '../../../services/app_access.service.dart';
import '../../../services/notification.service.dart';
import '../profile/widget/arguments.dart';

class PerformanceModel extends ViewModel {
  //Data
  CompanyLogoData get logo => locator<AppAccessService>().appAccess!.logo;


  late Map<String, dynamic> _data;
  Map<String, dynamic> get data => _data;

  Future<void> init(StaffPerformanceArguments argument) async {
    _data = argument.staffData;
    setIdle();
  }
}
