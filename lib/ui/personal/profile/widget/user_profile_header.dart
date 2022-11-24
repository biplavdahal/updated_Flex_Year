import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/staff.data.dart';
import 'package:flutter/material.dart';
import 'package:flex_year_tablet/data_models/user.data.dart';
import '../../../../services/authentication.service.dart';
import '../../../../widgets/user_avatar_widget.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({Key? key}) : super(key: key);

  StaffData get _user => locator<AuthenticationService>().user!.staff;

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
        _user.firstName + "" + _user.middleName + "" + _user.lastName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ]);
  }
}
