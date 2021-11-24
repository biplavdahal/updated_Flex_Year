import 'package:flex_year_tablet/data_models/leave_type.data.dart';

abstract class CompanyService {
  /// Leave types
  List<LeaveTypeData>? get leaveTypes;

  /// Preset all company required data by initing company service
  Future<void> init();
}
