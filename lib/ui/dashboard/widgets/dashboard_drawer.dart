import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/attendance_correction/attendance_correction.view.dart';
import 'package:flex_year_tablet/ui/attendance_correction_review/attendance_correction_review.view.dart';
import 'package:flex_year_tablet/ui/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/holidays/holidays.view.dart';
import 'package:flex_year_tablet/ui/leave_requests_received/leave_request_received.view.dart';
import 'package:flex_year_tablet/ui/profile/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = locator<DashboardModel>().user;

    return SizedBox(
      width: double.infinity,
      child: Drawer(
        elevation: 0,
        child: ListView(
          children: [
            Stack(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        _user.staff.firstName[0],
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    accountEmail: Text(_user.role!.toUpperCase()),
                    accountName: Text(
                        '[EMP - ${_user.staff.empId}] ${_user.staff.firstName} ${_user.staff.lastName}'),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 15,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      MdiIcons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(color: AppColor.primary),
              ),
              onTap: () {
                locator<DashboardModel>().goto(ProfileView.tag);
              },
              leading: const Icon(
                MdiIcons.accountOutline,
                color: AppColor.primary,
              ),
            ),
            ListTile(
              title: const Text(
                'Attendance Correction',
                style: TextStyle(color: AppColor.primary),
              ),
              onTap: () {
                locator<DashboardModel>().goto(AttendanceCorrectionView.tag);
              },
              leading: const Icon(
                MdiIcons.checkboxOutline,
                color: AppColor.primary,
              ),
            ),
            ListTile(
              title: const Text(
                'Holidays',
                style: TextStyle(color: AppColor.primary),
              ),
              onTap: () {
                locator<DashboardModel>().goto(HolidaysView.tag);
              },
              leading: const Icon(
                MdiIcons.calendarMonth,
                color: AppColor.primary,
              ),
            ),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() !=
                'staff')
              const Divider(),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() !=
                'staff')
              ListTile(
                title: const Text(
                  'Attendance Correction Requests',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  locator<DashboardModel>()
                      .goto(AttendanceCorrectionReviewView.tag);
                },
                leading: const Icon(
                  MdiIcons.checkboxMultipleMarked,
                  color: Colors.blue,
                ),
              ),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() !=
                'staff')
              ListTile(
                title: const Text(
                  'Add Attendance',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {},
                leading: const Icon(
                  MdiIcons.plusBoxMultiple,
                  color: Colors.blue,
                ),
              ),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() !=
                'staff')
              ListTile(
                title: const Text(
                  'Leave Request Received',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  locator<DashboardModel>().goto(LeaveRequestReceivedView.tag);
                },
                leading: const Icon(
                  MdiIcons.airplaneAlert,
                  color: Colors.blue,
                ),
              ),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() !=
                'staff')
              const Divider(),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                locator<DashboardModel>().logout();
              },
              leading: const Icon(
                MdiIcons.logout,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
