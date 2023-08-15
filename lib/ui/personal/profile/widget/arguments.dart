import 'package:bestfriend/model/arguments.model.dart';

import '../../../../data_models/staff_performance_allreport.dart';

class StaffPerformanceArguments implements Arguments {
  final Map<String, dynamic> staffData;

  StaffPerformanceArguments(this.staffData);
}
