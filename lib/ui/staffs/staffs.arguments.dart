import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/company_staff.data.dart';

class StaffsArguments extends Arguments {
  final bool isSelectMode;
  final List<CompanyStaffData>? selectedStaffs;
  final bool isSingleSelect;
  final bool preventSelf;

  StaffsArguments({
    this.isSelectMode = false,
    this.selectedStaffs,
    this.preventSelf = false,
    this.isSingleSelect = false,
  });
}
