import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/add_attendance/add_attendance.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/personal/date_converter/date_converter.view.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/leave_request_received.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.argument.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.view.dart';
import 'package:flex_year_tablet/ui/personal/profile/widget/user_profile_header.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../attendance_report_filter/attendance_report_filter.arguments.dart';
import '../../attendance_report_filter/attendance_report_filter.model.dart';
import '../../attendance_report_filter/attendance_report_filter.view.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: GestureDetector(
                      onTap: () {
                        locator<DashboardModel>().goto(ProfileView.tag);
                      },
                      child: UserProfileHeader(
                        textcolor: AppColor.primary,
                      ),
                    )),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      MdiIcons.close,
                      color: AppColor.primary,
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
                  'Leave Request ',
                  style: TextStyle(color: AppColor.primary),
                ),
                onTap: () {
                  locator<DashboardModel>().goto(LeaveRequestView.tag);
                },
                leading: locator<AuthenticationService>()
                                .user!
                                .role
                                ?.toLowerCase() ==
                            'manager' ||
                        locator<AuthenticationService>()
                                .user!
                                .role
                                ?.toLowerCase() ==
                            'admin' ||
                        locator<AuthenticationService>()
                                .user!
                                .role
                                ?.toLowerCase() ==
                            'super admin'
                    ? const Icon(
                        MdiIcons.airplaneAlert,
                        color: Colors.orange,
                      )
                    : const Icon(
                        MdiIcons.shieldAirplaneOutline,
                        color: Colors.orange,
                      )),
            ListTile(
              title: const Text(
                'Payroll',
                style: TextStyle(color: AppColor.primary),
              ),
              onTap: () {
                locator<DashboardModel>().goto(PayrollFilterView.tag,
                    arguments: PayrollFilterArguments(returnBack: false));
              },
              leading: const Icon(
                MdiIcons.cash,
                color: AppColor.primary,
              ),
            ),
            // if (_user.role != 'staff')
            //   ListTile(
            //     title: const Text(
            //       'Payroll',
            //       style: TextStyle(color: AppColor.primary),
            //     ),
            //     onTap: () {
            //       showModalBottomSheet(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return SizedBox(
            //               height: MediaQuery.of(context).size.height / 4,
            //               child: Container(
            //                 decoration: const BoxDecoration(
            //                     color: Colors.white,
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: AppColor.primary,
            //                         blurRadius: 10,
            //                         spreadRadius: 1,
            //                       )
            //                     ]),
            //                 alignment: Alignment.topCenter,
            //                 width: MediaQuery.of(context).size.width,
            //                 padding: const EdgeInsets.all(3),
            //                 child: Column(
            //                   children: [
            //                     ListTile(
            //                       title: const Text(
            //                         'Payroll',
            //                         style: TextStyle(color: AppColor.primary),
            //                       ),
            //                       onTap: () {
            //                         // locator<DashboardModel>().goto(
            //                         //   payrollView.tag,
            //                         // );
            //                       },
            //                       leading: const Icon(
            //                         MdiIcons.cash,
            //                         color: AppColor.primary,
            //                       ),
            //                     ),
            //                     ListTile(
            //                       title: const Text(
            //                         'Payroll Periods',
            //                         style: TextStyle(color: AppColor.primary),
            //                       ),
            //                       onTap: () {
            //                         locator<DashboardModel>().goto(
            //                           AttendanceReportFilterView.tag,
            //                           arguments:
            //                               AttendanceReportFilterArguments(
            //                             type:
            //                                 AttendanceReportFilterType.monthly,
            //                           ),
            //                         );
            //                       },
            //                       leading: const Icon(
            //                         MdiIcons.clockOutline,
            //                         color: AppColor.primary,
            //                       ),
            //                     ),
            //                     ListTile(
            //                       title: const Text(
            //                         'Payroll Parameters',
            //                         style: TextStyle(color: AppColor.primary),
            //                       ),
            //                       onTap: () {
            //                         locator<DashboardModel>().goto(
            //                           AttendanceReportFilterView.tag,
            //                           arguments:
            //                               AttendanceReportFilterArguments(
            //                             type: AttendanceReportFilterType.weekly,
            //                           ),
            //                         );
            //                       },
            //                       leading: const Icon(
            //                         MdiIcons.arrowUpBold,
            //                         color: AppColor.primary,
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             );
            //           });
            //     },
            //     leading: const Icon(
            //       MdiIcons.cash,
            //       color: AppColor.primary,
            //     ),
            //   ),
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
                        height: MediaQuery.of(context).size.height / 3,
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
                MdiIcons.fileDocument,
                color: Colors.green,
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
                MdiIcons.calendarStar,
                color: AppColor.primary,
              ),
            ),

            ListTile(
              title: const Text(
                'Date Converter',
                style: TextStyle(color: AppColor.primary),
              ),
              onTap: () {
                locator<DashboardModel>().goto(DateConverterView.tag);
              },
              leading: const Icon(
                MdiIcons.swapHorizontalBold,
                color: AppColor.primary,
              ),
            ),
            ListTile(
              title: const Text('Exit Process',
                  style: TextStyle(color: AppColor.primary)),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
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
                                  'Resignation',
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                onTap: () {
                                  locator<DashboardModel>()
                                      .goto(ResignView.tag);
                                },
                                leading: const Icon(
                                  MdiIcons.doorOpen,
                                  color: Colors.orange,
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Clearance',
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                onTap: () {
                                  locator<DashboardModel>()
                                      .goto(ResignView.tag);
                                },
                                leading: const Icon(
                                  MdiIcons.doorClosedLock,
                                  color: Colors.orange,
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Exit Interview',
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                onTap: () {
                                  locator<DashboardModel>()
                                      .goto(ResignView.tag);
                                },
                                leading: const Icon(
                                  MdiIcons.chatQuestion,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              leading: const Icon(
                MdiIcons.doorSlidingOpen,
                color: Color.fromARGB(255, 240, 119, 82),
              ),
            ),
            // ListTile(
            //   title: const Text(
            //     'Resign',
            //     style: TextStyle(color: AppColor.primary),
            //   ),
            //   onTap: () {
            //     locator<DashboardModel>().goto(ResignView.tag);
            //   },
            //   leading: const Icon(
            //     MdiIcons.doorOpen,
            //     color: AppColor.primary,
            //   ),
            // ),

            const Divider(),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'manager' ||
                locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'admin' ||
                locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'super admin')
              ListTile(
                title: const Text(
                  'Attendance Correction Requests',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  locator<DashboardModel>().goto(AttendanceCorrectionView.tag);
                },
                leading: const Icon(
                  MdiIcons.checkboxMultipleMarked,
                  color: Colors.blue,
                ),
              ),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'manager' ||
                locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'admin' ||
                locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'super admin')
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
                    'manager' ||
                locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'admin' ||
                locator<AuthenticationService>().user!.role?.toLowerCase() ==
                    'super admin')
              ListTile(
                title: const Text(
                  'Create Access Message',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {},
                leading: const Icon(
                  MdiIcons.plusBoxMultiple,
                  color: Colors.blue,
                ),
              ),
            // if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
            //         'manager' ||
            //     locator<AuthenticationService>().user!.role?.toLowerCase() ==
            //         'admin' ||
            //     locator<AuthenticationService>().user!.role?.toLowerCase() ==
            //         'super admin')
            //   ListTile(
            //     title: const Text(
            //       'Leave Request Received',
            //       style: TextStyle(color: Colors.blue),
            //     ),
            //     onTap: () {
            //       locator<DashboardModel>().goto(LeaveRequestReceivedView.tag);
            //     },
            //     leading: const Icon(
            //       MdiIcons.airplaneAlert,
            //       color: Colors.blue,
            //     ),
            //   ),
            if (locator<AuthenticationService>().user!.role?.toLowerCase() ==
                'manager')
              const Divider(
                color: AppColor.primary,
              ),
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
            ),
            const SizedBox(
              height: 15,
            ),
            const ListTile(
              title: Text(
                '       © 2023, All Rights Reserved | Design by Bent Ray Technologies',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
