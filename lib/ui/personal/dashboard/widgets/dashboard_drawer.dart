import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/add_attendance/add_attendance.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction_review/attendance_correction_review.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/leave_request_received.view.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../attendance_report_filter/attendance_report_filter.arguments.dart';
import '../../attendance_report_filter/attendance_report_filter.model.dart';
import '../../attendance_report_filter/attendance_report_filter.view.dart';

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
                      radius: 40,
                      backgroundColor: AppColor.primary,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColor.primary.withOpacity(0.5),
                        backgroundImage:
                            const AssetImage("assets/images/avatar.png"),
                      ),
                    ),
                    accountEmail: Text(_user.role != null
                        ? _user.role!.toUpperCase()
                        : 'Staff'),
                    accountName: Text(
                        '${_user.staff.firstName} ${_user.staff.lastName}'),
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
            if (_user.role == 'staff')
              ListTile(
                title: const Text(
                  'Leave Request ',
                  style: TextStyle(color: AppColor.primary),
                ),
                onTap: () {
                  locator<DashboardModel>().goto(LeaveRequestView.tag);
                },
                leading: const Icon(
                  MdiIcons.shieldAirplaneOutline,
                  color: Colors.orange,
                ),
              ),
            if (_user.role != 'staff')
              ListTile(
                title: const Text(
                  'Leave Request',
                  style: TextStyle(color: Colors.orange),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  )
                                ]),
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(3),
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Create Leave Request',
                                    style: TextStyle(color: AppColor.primary),
                                  ),
                                  onTap: () {
                                    locator<DashboardModel>()
                                        .goto(LeaveRequestView.tag);
                                  },
                                  leading: const Icon(
                                    MdiIcons.planeCar,
                                    color: Colors.orange,
                                  ),
                                ),
                                ListTile(
                                  title: const Text(
                                    'Leave Request Received',
                                    style: TextStyle(color: AppColor.primary),
                                  ),
                                  onTap: () {
                                    locator<DashboardModel>()
                                        .goto(LeaveRequestReceivedView.tag);
                                  },
                                  leading: const Icon(
                                    MdiIcons.downloadBoxOutline,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                leading: const Icon(
                  MdiIcons.shieldAirplaneOutline,
                  color: Colors.orange,
                ),
              ),
            ListTile(
              title: const Text(
                'Reports',
                style: TextStyle(color: AppColor.primary),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primary,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                )
                              ]),
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'One-Day Report',
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                onTap: () {
                                  locator<DashboardModel>().goto(
                                    AttendanceReportFilterView.tag,
                                    arguments: AttendanceReportFilterArguments(
                                      type: AttendanceReportFilterType
                                          .oneDayReport,
                                    ),
                                  );
                                },
                                leading: const Icon(
                                  MdiIcons.chartBoxOutline,
                                  color: Colors.green,
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Monthly Report',
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                onTap: () {
                                  locator<DashboardModel>().goto(
                                    AttendanceReportFilterView.tag,
                                    arguments: AttendanceReportFilterArguments(
                                      type: AttendanceReportFilterType.monthly,
                                    ),
                                  );
                                },
                                leading: const Icon(
                                  MdiIcons.chartBoxOutline,
                                  color: Colors.green,
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Weekly Report',
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                onTap: () {
                                  locator<DashboardModel>().goto(
                                    AttendanceReportFilterView.tag,
                                    arguments: AttendanceReportFilterArguments(
                                      type: AttendanceReportFilterType.weekly,
                                    ),
                                  );
                                },
                                leading: const Icon(
                                  MdiIcons.chartBoxOutline,
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              leading: const Icon(
                MdiIcons.chartBoxOutline,
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
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                'manager')
              const Divider(),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                'manager')
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
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                'manager')
              ListTile(
                title: const Text(
                  'Add Attendance',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  locator<DashboardModel>().goto(AddAttendanceView.tag);
                },
                leading: const Icon(
                  MdiIcons.plusBoxMultiple,
                  color: Colors.blue,
                ),
              ),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                'manager')
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
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                'manager')
              const Divider(),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                final isConfirm = DialogRequest(
                  title: "Are you sure you want to exit app.",
                  type: DialogType.confirmation,
                  dismissable: true,
                );
                if (isConfirm == 0) {
                } else {
                  locator<DashboardModel>().logout();
                }
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
