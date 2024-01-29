import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/department_list.data.dart';
import 'package:flex_year_tablet/services/user_service.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory_detail/staff_directory_argument.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory_detail/staff_directory_detail.view.dart';

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

  Future<void> onClick(String departmentName, int departId) async {
    setLoading();

    // Allow the UI to update before navigating
    await Future.microtask(() async {
      Map<String, dynamic> searchParams = {};
      searchParams['limit'] = 15;
      searchParams['page'] = 1;
      searchParams['search'] = [
        {'department_name': departmentName, 'description': ''}
      ];

      await goto(StaffDirectoryDetailView.tag,
          arguments: StaffDirectoryArgument(
              searchParams: searchParams, departID: departId));
    });

    setIdle();
  }
}
