import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/services/user_service.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory_detail/staff_directory_argument.dart';

import '../../../../data_models/department_detail_list.data.dart';

class StaffDirectoryDetailViewModel extends ViewModel with SnackbarMixin {
  //Service
  final UserService _userService = locator<UserService>();
//data
  List<DepartmentDetailListdata> get details => _userService.details;
  late Map<String, dynamic> _searchParams;
  Map<String, dynamic> get searchParams => _searchParams;

  int? index;

  Future<void> init(StaffDirectoryArgument argument) async {
    _searchParams = argument.searchParams;
    setIdle();
    try {
      setLoading();
      final _staffDetail = await _userService.getDepartmentDetailList(
          data: _searchParams, id: argument.departID);
      _userService.details = _staffDetail;
      setSuccess();
    } catch (e) {
      rethrow;
    }
  }
}
