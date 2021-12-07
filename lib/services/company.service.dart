import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/company_staff.data.dart';
import 'package:flex_year_tablet/data_models/holiday.data.dart';
import 'package:flex_year_tablet/data_models/leave_type.data.dart';

abstract class CompanyService {
  /// Leave types
  List<LeaveTypeData>? get leaveTypes;

  /// Getter for clients
  List<ClientData>? get clients;

  /// Preset all company required data by initing company service
  Future<void> init();

  /// Get company holidays
  Future<List<HolidayData>> getHolidays();

  /// Get all staffs
  Future<List<CompanyStaffData>> getStaffs({
    String? clientId,
  });
}
