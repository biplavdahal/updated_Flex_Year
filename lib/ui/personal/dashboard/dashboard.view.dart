import 'package:bestfriend/bestfriend.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/attendance_forgot.data.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/presentStaff/presentstaff.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/attendance_button.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/dashboard_drawer.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/dashboard_todays_attendance_activities.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/report_item.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/utility_item.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/personal/holidays/widgets/holiday_item.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/personal/notice/notice.view.dart';
import 'package:flex_year_tablet/ui/personal/notifications/notification.view.dart';
import 'package:flex_year_tablet/ui/personal/payroll/payroll_filter/payroll.filter.view.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.arguments.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.view.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory.view.dart';
import 'package:flex_year_tablet/ui/personal/upcoming_birthday/upcoming_birthday.view.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flex_year_tablet/widgets/fy_section.widget.dart';
import 'package:flex_year_tablet/widgets/fy_user_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../attendance_correction/attendance_correction.view.dart';
import '../chat_contacts/chat_contacts.view.dart';
import '../holidays/holidays.view.dart';
import '../payroll/payroll_filter/payroll.filter.argument.dart';

class DashboardView extends StatelessWidget {
  static String tag = "dashboard-view";

  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrontView<DashboardModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        final todayBirthdays = model.staffBirthdayData.where((staff) {
          final staffDobParts = staff.dob!.split('-');
          final staffDob = DateTime(
            int.parse(staffDobParts[0]),
            int.parse(staffDobParts[1]),
            int.parse(staffDobParts[2]),
          );
          return staffDob.month == model.today.month &&
              staffDob.day == model.today.day;
        });
        if (todayBirthdays.isNotEmpty && !model.isBirthdaySnackBarShown) {
          final staffNames = todayBirthdays
              .map((staff) => '${staff.firstName} ${staff.lastName}')
              .join(', ');
          model.isBirthdaySnackBarShown = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: AppColor.primary,
                content: Text("It's $staffNames's birthday today! "),
                duration: const Duration(seconds: 10),
              ),
            );
          });
        }

        return Scaffold(
          backgroundColor: AppColor.primary,
          drawer: const Drawer(
            backgroundColor: Colors.white,
            child: DashboardDrawer(),
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: RefreshIndicator(
              onRefresh: model.init,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (model.attendanceCorrectionData.isNotEmpty)
                    //   _buildProgressIndicator(model),
                    _buildValidAttendance(model),
                    _buildAttendanceActivities(model),
                    _buildForgotToCheckout(model),
                    _buildTodaysAttendance(model),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildUtilities(model, context),
                    const SizedBox(
                      height: 15,
                    ),
                    if (model.monthlyReport.isNotEmpty)
                      _buildCurrentReport(model),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildCalander(model)
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: AppColor.primary,
            color: Colors.white,
            height: 48,
            index: model.currentFragment,
            onTap: (value) => model.currentFragment = value,
            items: [
              const Icon(
                Icons.check_box_outlined,
                color: AppColor.primary,
              ),
              const Icon(
                Icons.airplanemode_active,
                size: 25,
                color: AppColor.primary,
              ),
              const Icon(
                Icons.home,
                size: 30,
                color: AppColor.primary,
              ),
              const Icon(
                Icons.calendar_month,
                size: 25,
                color: AppColor.primary,
              ),
              UserAvatar(
                user: model.user.staff,
                size: 15,
              )
            ],
            animationCurve: Curves.fastLinearToSlowEaseIn,
          ),
          floatingActionButton: Wrap(
            direction: Axis.vertical,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: const PresentStaffView(),
                        );
                      });
                },
                child: const Icon(Icons.people),
                backgroundColor: AppColor.accent,
              ),
              const SizedBox(
                height: 5,
              ),
              FloatingActionButton(
                onPressed: () async {
                  await model.goto(ChatContactsView.tag);
                },
                child: const Icon(Icons.chat_bubble),
                backgroundColor: AppColor.accent,
              ),
            ],
          ),
          appBar: AppBar(
            centerTitle: true,
            title: auBaseURL + model.logo.logoPath == null
                ? Image.network(
                    auBaseURL + model.logo.logoPath,
                    width: 150,
                    height: MediaQuery.of(context).size.height,
                  )
                : Image.asset(
                    "assets/images/flex_year_login_image.png",
                    width: 145,
                  ),
            bottom: PreferredSize(
              child: Container(
                color: AppColor.primary,
                child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (model.company.companyPreference == 'N')
                              Text(
                                "  " +
                                    formattedNepaliDate(model.currentDateTime),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (model.company.companyPreference != 'N')
                              Text(
                                "  " + formattedDate(model.currentDateTime),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 20,
                                    child: VerticalDivider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    formattedTime(model.currentDateTime),
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _getGreeting() +
                                      " " +
                                      model.user.staff.firstName.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              preferredSize: const Size(double.infinity, 70),
            ),
            actions: [
              IconButton(
                  tooltip: "notice",
                  iconSize: 24.1,
                  onPressed: () async {
                    await locator<DashboardModel>().goto(NoticeView.tag);
                  },
                  icon: const Icon(
                    Icons.note,
                  )),
              IconButton(
                tooltip: "notification",
                iconSize: 25,
                onPressed: () async {
                  await locator<DashboardModel>().goto(AllNotificationView.tag);
                },
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildValidAttendance(DashboardModel model) {
    return model.company.companyId != 1
        ? Container()
        : const Text(
            "Your attendance data valid from : 09:00:00 to 18:00:00",
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.w700,
            ),
          );
  }

  Widget _buildAttendanceActivities(DashboardModel model) {
    return model.attendanceCorrectionData.isNotEmpty
        ? FYSection(
            title: "Today's Attendance Activities",
            child: SizedBox(
              height: 68,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 11,
                ),
                itemBuilder: (context, index) {
                  final _correction = model.attendanceCorrectionData[index];
                  return TodaysAttendanceActivities(
                    _correction,
                  );
                },
                itemCount: model.attendanceCorrectionData.length,
              ),
            ),
          )
        : Container();
  }

  Widget _buildForgotToCheckout(DashboardModel model) {
    return model.attendanceForgot == null
        ? Container()
        : FYSection(
            infoBox: true,
            title: "Forgot To Checkout",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "You forgot to checkout in ${model.attendanceForgot!.forgottonDate}. You can not checkout next time until review previous checkout.",
                ),
                const SizedBox(
                  height: 10,
                ),
                FYPrimaryButton(
                  label:
                      "Checkout Request for ${model.attendanceForgot!.forgottonDate}",
                  onPressed: () async {
                    final response = await locator<DashboardModel>().goto(
                      RequestReviewView.tag,
                      arguments: RequestReviewArguments<AttendanceForgotData>(
                        type: RequestReviewType.checkoutReview,
                        payload: model.attendanceForgot,
                      ),
                    );

                    if (response) {
                      model.init();
                    }
                  },
                  backgroundColor: Colors.orange,
                ),
              ],
            ),
          );
  }

  Widget _buildTodaysAttendance(DashboardModel model) {
    return FYSection(
      title: "Today's Attendance",
      child: model.isBusyWidget('todays-attendance')
          ? const FYLinearLoader()
          : Column(
              children: [
                if (model.clientLabels != null &&
                    model.clientLabels!.isNotEmpty)
                  FYDropdown<ClientData>(
                    title: "Select client",
                    labels: model.clientLabels!,
                    items: model.user.clients,
                    onChanged: model.onClientChanged,
                    value: model.selectedClientLabel!,
                  ),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 3.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    AttendanceButton(
                      titles: '',
                      title: "Check In",
                      icon: MdiIcons.clockStart,
                      color: Colors.green,
                      onPressed: model.attendanceStatus?.checkIn == null ||
                              model.attendanceStatus?.checkIn == 1
                          ? () {
                              model.onAttendanceButtonPressed('checkin',
                                  model.attendanceMessageController.toString());
                            }
                          : null,
                    ),
                    AttendanceButton(
                      titles: "",
                      title: "Check Out",
                      icon: MdiIcons.clockEnd,
                      color: Colors.red,
                      onPressed: model.attendanceStatus?.checkOut == 1
                          ? () {
                              model.onAttendanceButtonPressed('checkout',
                                  model.attendanceMessageController.toString());
                            }
                          : null,
                    ),
                    if (model.attendanceStatus?.checkIn == 0)
                      AttendanceButton(
                        titles: "",
                        title: "Lunch In",
                        icon: MdiIcons.food,
                        color: AppColor.primary,
                        onPressed: model.attendanceStatus?.lunchIn == 1
                            ? () {
                                model.onAttendanceButtonPressed(
                                    'lunchin',
                                    model.attendanceMessageController
                                        .toString());
                              }
                            : null,
                      ),
                    if (model.attendanceStatus?.checkIn == 0)
                      AttendanceButton(
                        titles: "",
                        title: "Lunch Out",
                        icon: MdiIcons.foodOff,
                        color: AppColor.primary,
                        onPressed: model.attendanceStatus?.lunchOut == 1
                            ? () {
                                model.onAttendanceButtonPressed(
                                    'lunchout',
                                    model.attendanceMessageController
                                        .toString());
                              }
                            : null,
                      ),
                    if (model.attendanceStatus?.checkIn == 0)
                      AttendanceButton(
                          titles: "",
                          title: "Onsite In",
                          icon: MdiIcons.bicycle,
                          color: AppColor.primary,
                          onPressed: model.attendanceStatus?.onsiteIn == 1
                              ? () {
                                  model.onAttendanceButtonPressed(
                                      'onsitein',
                                      model.attendanceMessageController
                                          .toString());
                                }
                              : null),
                    if (model.attendanceStatus?.checkIn == 0)
                      AttendanceButton(
                          titles: "",
                          title: "Onsite Out",
                          icon: MdiIcons.bicycle,
                          color: AppColor.primary,
                          onPressed: model.attendanceStatus?.onsiteOut == 1
                              ? () {
                                  model.onAttendanceButtonPressed(
                                      'onsiteout',
                                      model.attendanceMessageController
                                          .toString());
                                }
                              : null),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    child: FYInputField(
                  label: 'Attendance Message',
                  title: 'Attendance Message',
                  controller: model.attendanceMessageController,
                )),
              ],
            ),
    );
  }

  Widget _buildUtilities(DashboardModel model, BuildContext context) {
    return FYSection(
      title: "Utilities",
      child: GridView.custom(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            late Widget utilityItem;
            if (index == 0) {
              utilityItem = UtilityItem(
                title: "Leave    Request",
                labelText: model.user.staff.remainingLeave,
                icon: MdiIcons.shieldAirplaneOutline,
                iconColor: Colors.orange,
                onPressed: () async {
                  model.goto(LeaveRequestView.tag);
                },
              );
            } else if (index == 1) {
              utilityItem = UtilityItem(
                title: "One-day  Report",
                iconColor: Colors.lightGreen,
                icon: MdiIcons.chartBoxOutline,
                onPressed: () {
                  model.goto(
                    AttendanceReportFilterView.tag,
                    arguments: AttendanceReportFilterArguments(
                      type: AttendanceReportFilterType.daily,
                    ),
                  );
                },
              );
            } else if (index == 2) {
              utilityItem = UtilityItem(
                title: "Weekly    Report",
                iconColor: Colors.lightGreen,
                icon: MdiIcons.chartBoxOutline,
                onPressed: () {
                  model.goto(
                    AttendanceReportFilterView.tag,
                    arguments: AttendanceReportFilterArguments(
                      type: AttendanceReportFilterType.weekly,
                    ),
                  );
                },
              );
            } else if (index == 3) {
              utilityItem = UtilityItem(
                title: " Monthly  Report",
                iconColor: Colors.lightGreen,
                icon: MdiIcons.chartBoxOutline,
                onPressed: () {
                  model.goto(
                    AttendanceReportFilterView.tag,
                    arguments: AttendanceReportFilterArguments(
                      type: AttendanceReportFilterType.monthly,
                    ),
                  );
                },
              );
            } else if (index == 4) {
              utilityItem = UtilityItem(
                title: " Payroll  ",
                iconColor: AppColor.primary,
                icon: MdiIcons.cash,
                onPressed: () {
                  model.goto(PayrollFilterView.tag,
                      arguments: PayrollFilterArguments(returnBack: false));
                },
              );
            } else if (index == 5) {
              utilityItem = UtilityItem(
                title: "Attendance Corrections",
                iconColor: AppColor.primary,
                icon: MdiIcons.checkboxOutline,
                onPressed: () {
                  model.goto(AttendanceCorrectionView.tag);
                },
              );
            } else if (index == 6) {
              utilityItem = UtilityItem(
                title: "Holidays",
                iconColor: AppColor.primary,
                icon: MdiIcons.calendarStar,
                onPressed: () {
                  model.goto(HolidaysView.tag);
                },
              );
            } else if (index == 7) {
              utilityItem = UtilityItem(
                title: "Birthdays",
                iconColor: AppColor.primary,
                icon: MdiIcons.cake,
                onPressed: () {
                  model.goto(AllStaffBirthdayView.tag);
                },
              );
            } else if (index == 8) {
              utilityItem = UtilityItem(
                title: "Staff     Directory",
                iconColor: AppColor.primary,
                icon: Icons.groups,
                onPressed: () {
                  model.goto(StaffDirectoryView.tag);
                },
              );
            }
            return utilityItem;
          },
          childCount: 9,
        ),
      ),
    );
  }

  Widget _buildCurrentReport(DashboardModel model) {
    return FYSection(
      title: "Current Month Attendance Report",
      child: SizedBox(
        height: 112,
        width: double.infinity,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  child: _buildTotalHrsCard(model),
                ),
                const SizedBox(
                  width: 2,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: model.monthlyReport.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 3),
                  itemBuilder: (context, index) {
                    final _report = model.monthlyReport[index];
                    return MonthlyHorizontalReportItems(_report, index,
                        onTap: () async {
                      await locator<DashboardModel>().goto(
                          AttendanceSummaryView.tag,
                          arguments:
                              AttendanceSummaryArguments(date: _report.date));
                    });
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildTotalHrsCard(DashboardModel model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      margin: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Total hrs : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  convertIntoHrs(model.WorkingHours?.toString() ?? 'N/A'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              "Leave : ${model.Leave} days",
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            Text(
              "Holiday : ${model.holidays} days",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColor.primary,
              ),
            ),
            Text(
              'Present : ${model.present} days',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            Text(
              'Absent : ${model.absent} days',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalander(DashboardModel model) {
    return FYSection(
        title: "Upcoming Holidays ",
        child: model.isLoading
            ? null
            : SizedBox(
                height: 100,
                child: RefreshIndicator(
                    onRefresh: HolidaysModel.holidaydata,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final _holiday = HolidaysModel.holiday[index];
                        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                        DateTime date = dateFormat.parse(_holiday.date);

                        if (date.compareTo(DateTime.now()) < 0) {
                          return Container();
                        }
                        return HolidayItem(holiday: _holiday);
                      },
                      itemCount: HolidaysModel.holiday.length,
                    )),
              ));
  }

  // Widget _buildProgressIndicator(DashboardModel model) {
  //   if (model.attendanceCorrectionData.isEmpty) {
  //     return const Text('No attendance data available');
  //   }

  //   double progress = model.calculateProgress();

  //   late DateTime checkoutTime;
  //   if (model.attendanceCorrectionData.isNotEmpty &&
  //       model.attendanceCorrectionData.last.checkoutDatetime != null) {
  //     checkoutTime =
  //         DateTime.parse(model.attendanceCorrectionData.last.checkoutDatetime!);
  //   } else {
  //     checkoutTime = DateTime.now();
  //   }

  //   DateTime checkinTime =
  //       DateTime.parse(model.attendanceCorrectionData[0].checkinDatetime!);
  //   DateTime now = DateTime.now();
  //   Duration remainingTime =
  //       checkinTime.add(const Duration(hours: 8, minutes: 30)).difference(now);
  //   Color progressBarColor = progress >= 1.0 ? Colors.green : AppColor.primary;

  //   Duration difference = checkoutTime.difference(checkinTime);

  //   return SizedBox(
  //     height: 20,
  //     child: LiquidLinearProgressIndicator(
  //       value: progress.clamp(0.0, 1.0),
  //       valueColor: AlwaysStoppedAnimation(progressBarColor),
  //       backgroundColor: Colors.grey,
  //       borderColor: Colors.white,
  //       borderWidth: 1.0,
  //       borderRadius: 12.0,
  //       direction: Axis.horizontal,
  //       center: Text(
  //         model.attendanceCorrectionData.isNotEmpty &&
  //                 model.attendanceCorrectionData.last.checkoutDatetime != null
  //             ? "Today time: ${formatDuration(difference)}"
  //             : "Remaining Time: ${remainingTime.inHours}h ${remainingTime.inMinutes.remainder(60)}m ${remainingTime.inSeconds.remainder(60)}s",
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 11,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  String _getGreeting() {
    final currentTime = DateTime.now();

    if (currentTime.hour < 12) {
      return "Good Morning,";
    } else if (currentTime.hour < 18) {
      return "Good Afternoon,";
    } else {
      return "Good Evening,";
    }
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    List<String> parts = [];
    if (hours > 0) {
      parts.add('$hours hr');
    }
    if (minutes > 0) {
      parts.add('$minutes min');
    }
    if (seconds > 0 || (hours == 0 && minutes == 0)) {
      parts.add('$seconds sec');
    }

    return parts.join(' ');
  }
}
