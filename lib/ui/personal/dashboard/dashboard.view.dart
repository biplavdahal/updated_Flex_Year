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
import 'package:flex_year_tablet/ui/personal/chat_contacts/chat_contacts.view.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/attendance_button.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/dashboard_drawer.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/dashboard_todays_attendance_activities.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/lastcard.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/progress.item.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/report_item.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/summary.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/widgets/utility_item.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/personal/holidays/widgets/holiday_item.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.view.dart';
import 'package:flex_year_tablet/ui/personal/notice/notice.view.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.arguments.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.view.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flex_year_tablet/widgets/fy_section.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../data_models/attendance_report_summary.data.dart';

class DashboardView extends StatelessWidget {
  static String tag = "dashboard-view";

  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<DashboardModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          backgroundColor: AppColor.primary,
          drawer: const DashboardDrawer(),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: AppColor.primary,
            color: Colors.white,
            height: 52,
            index: model.currentFragment,
            onTap: (value) => model.currentFragment = value,
            items: const [
              Icon(
                MdiIcons.checkboxOutline,
              ),
              Icon(MdiIcons.shieldAirplaneOutline, size: 25),
              Icon(MdiIcons.home, size: 30),
              Icon(MdiIcons.calendarMonth, size: 25),
              Icon(MdiIcons.accountGroupOutline, size: 25),
            ],
            animationCurve: Curves.fastLinearToSlowEaseIn,
          ),
          floatingActionButton: model.isLoading
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    model.goto(ChatContactsView.tag);
                  },
                  child: const Icon(Icons.chat_bubble),
                  backgroundColor: AppColor.accent,
                ),
          appBar: AppBar(
            centerTitle: true,
            title: Image.network(
              auBaseURL + model.logo.logoPath,
              width: 150,
              height: MediaQuery.of(context).size.height,
            ),
            bottom: PreferredSize(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  formattedDate(model.currentDateTime),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome ! " +
                                    model.user.staff.firstName +
                                    model.user.staff.middleName +
                                    " " +
                                    model.user.staff.lastName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
              preferredSize: const Size(double.infinity, 60),
            ),
            actions: [
              IconButton(
                  tooltip: "notice",
                  iconSize: 24.1,
                  onPressed: () async {
                    await locator<DashboardModel>().goto(NoticeView.tag);
                  },
                  icon: const Icon(MdiIcons.noteText)),
              // IconButton(
              //   tooltip: "notification",
              //   iconSize: 25,
              //   onPressed: () {},
              //   icon: const Icon(MdiIcons.bellOutline),
              // ),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F1F1),
              borderRadius: BorderRadius.only(
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
                    _buildValidAttendance(model),
                    _buildAttendanceActivities(model),
                    _buildForgotToCheckout(model),
                    _buildTodaysAttendance(model),
                    _buildUtilities(model),
                    if (model.monthlyReport.isNotEmpty)
                      _buildCurrentReport(model),
                    _buildCalander(model)
                  ],
                ),
              ),
            ),
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
                              model.onAttendanceButtonPressed('checkin');
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
                              model.onAttendanceButtonPressed('checkout');
                            }
                          : null,
                    ),
                    AttendanceButton(
                      titles: "",
                      title: "Lunch In",
                      icon: MdiIcons.food,
                      color: AppColor.primary,
                      onPressed: model.attendanceStatus?.lunchIn == 1
                          ? () {
                              model.onAttendanceButtonPressed('lunchin');
                            }
                          : null,
                    ),
                    AttendanceButton(
                      titles: "",
                      title: "Lunch Out",
                      icon: MdiIcons.foodOff,
                      color: AppColor.primary,
                      onPressed: model.attendanceStatus?.lunchOut == 1
                          ? () {
                              model.onAttendanceButtonPressed('lunchout');
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildUtilities(DashboardModel model) {
    return FYSection(
      title: "Utilities",
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        shrinkWrap: true,
        crossAxisSpacing: 8,
        children: [
          UtilityItem(
            title: 'Leave Request  ',
            icon: MdiIcons.shieldAirplaneOutline,
            iconColor: Colors.orange,
            onPressed: () async {
              model.goto(LeaveRequestView.tag);
            },
          ),
          UtilityItem(
            title: " Monthly Report",
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
          ),
          UtilityItem(
            title: "One-day Report",
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
          ),
          // if (model.clientLabels != null && model.clientLabels!.isNotEmpty)
          UtilityItem(
            title: "Weekly Report",
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
          )
        ],
      ),
    );
  }

  Widget _buildCurrentReport(DashboardModel model) {
    return FYSection(
        title: "Current Month Attendance Report : ",
        child: model.isLoading
            ? const FYLinearLoader()
            : SizedBox(
                height: 150,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.monthlyReport.length + 1,
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 5,
                        ),
                    itemBuilder: (context, index) {
                      if (index == model.monthlyReport.length) {
                        return SizedBox(
                          height: 150,
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        "Total(Hrs)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          model.WorkingHours as String,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Leave : ${model.Leave}",
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Holiday : ${model.holidays}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text('Present : ${model.present}',
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600)),
                                  Text('Absent : ${model.absent}',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      final _report = model.monthlyReport[index];
                      return MonthlyHorizontalReportItems(_report, index,
                          onTap: () async {
                        await locator<DashboardModel>().goto(
                            AttendanceSummaryView.tag,
                            arguments:
                                AttendanceSummaryArguments(date: _report.date));
                        model.goto(AttendanceSummaryView.tag,
                            arguments: AttendanceSummaryArguments(
                              date: _report.date,
                            ));
                      });
                    }),
              ));
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
}
