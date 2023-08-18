import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';
import '../../../../services/authentication.service.dart';
import '../../../../widgets/fy_user_avatar_widget.dart';
import '../../dashboard/dashboard.model.dart';

class UserProfileHeader extends StatelessWidget {
  final Color textcolor;
  UserProfileHeader({Key? key, required this.textcolor}) : super(key: key);

  final StaffData _user = locator<AuthenticationService>().user!.staff;
  final _users = locator<DashboardModel>().user;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      UserAvatar(
        user: _user,
        size: 44,
        borderWidth: 2,
        borderColor: Colors.white,
      ),
      const SizedBox(height: 10),
      Text(
        "   " +
            _user.firstName +
            "  " +
            _user.middleName +
            "" +
            _user.lastName +
            " [ " +
            _users.role.toString() +
            " ]",
        style: TextStyle(
          color: textcolor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      if (textcolor == AppColor.primary) const Divider(),
      const Divider(
        color: AppColor.primary,
      )
    ]);
  }
}

// Text(_user.role != null
//                         ? _user.role!.toUpperCase()
//                         : 'Staff'),
