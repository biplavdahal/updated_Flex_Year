import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/user.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/ui/personal/change_password/change_password_view.dart';
import '../edit_profile/edit_profile.view.dart';

class ProfileModel extends ViewModel {
  // Data
  UserData get user => locator<AuthenticationService>().user!;
  List<String> get tabs => ['General', 'Official'];
  String _selectedTab = '0';
  String get selectedTab => _selectedTab;

  set selectedTab(String tab) {
    _selectedTab = tab;
    setIdle();
  }
 

  Future<void> moreOptionActions(String action) async {
    switch (action) {
      case 'change_password':
        await goto(ChangePasswordView.tag);
        setIdle();
        break;
      case 'update_profile':
        await goto(EditProfileView.tag);
        setIdle();
        break;
    }
  }
}
