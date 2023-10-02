import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/department_list.data.dart';
import 'package:flex_year_tablet/services/user_service.dart';

class StaffDirectoryViewModel extends ViewModel with SnackbarMixin {
  //Service
  final UserService _userService = locator<UserService>();

  List<DepartmentListdata> _departmentListData = [];
  List<DepartmentListdata> get departmentListData => _departmentListData;

  Future<void> init() async {
    try {
      setLoading();
      _departmentListData = await _userService.getDepartmentList();
      setIdle();
    } catch (e) {
      rethrow;
    }
  }
}
