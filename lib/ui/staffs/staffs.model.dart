import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/company_staff.data.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/ui/staffs/staffs.arguments.dart';
import 'package:flutter/material.dart';

class StaffsModel extends ViewModel with SnackbarMixin {
  // Services
  final CompanyService _companyService = locator<CompanyService>();

  // UI controllers
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  // Data
  bool _isSelectMode = false;
  bool get isSelectMode => _isSelectMode;

  String _query = "";
  String get query => _query;
  set query(String value) {
    _query = value;
    setIdle();
  }

  List<CompanyStaffData> _staffs = [];

  List<CompanyStaffData> get staffsToShow => _staffs
      .where((element) =>
          element.fullName.toLowerCase().contains(query.toLowerCase()))
      .toList();

  final Set<CompanyStaffData> _selectedStaffs = {};
  Set<CompanyStaffData> get selectedStaffs => _selectedStaffs;
  void addSelectedStaffs(CompanyStaffData staff) {
    if (_selectedStaffs.contains(staff)) {
      _selectedStaffs.remove(staff);
    } else {
      _selectedStaffs.add(staff);
    }
    setIdle();
  }

  bool isSelected(CompanyStaffData staff) => _selectedStaffs.contains(staff);

  // Action
  Future<void> init(StaffsArguments? arguments) async {
    if (arguments != null) {
      _isSelectMode = arguments.isSelectMode;
    }
    setIdle();

    try {
      setLoading();

      _staffs = await _companyService.getStaffs();

      _searchController.addListener(() {
        query = _searchController.text;
      });

      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
