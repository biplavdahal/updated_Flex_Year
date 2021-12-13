import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/user.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';

class ProfileModel extends ViewModel {
  // Data
  UserData get user => locator<AuthenticationService>().user!;
}
