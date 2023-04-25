import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flutter/material.dart';
import '../../../../services/authentication.service.dart';
import '../../../../widgets/fy_user_avatar_widget.dart';
import '../../dashboard/dashboard.model.dart';

class UserProfileHeader extends StatelessWidget {
  UserProfileHeader({Key? key}) : super(key: key);

  final StaffData _user = locator<AuthenticationService>().user!.staff;
  final _users = locator<DashboardModel>().user;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      UserAvatar(
        user: _user,
        size: 48,
        borderWidth: 2,
        borderColor: Colors.white,
      ),
      const SizedBox(height: 10),
      Text(
        _user.firstName +
            "" +
            _user.middleName +
            "" +
            _user.lastName +
            " [ " +
            _users.role.toString() +
            " ]",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ]);
  }
}

// Text(_user.role != null
//                         ? _user.role!.toUpperCase()
//                         : 'Staff'),
