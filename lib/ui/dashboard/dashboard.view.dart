import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/dashboard/dashboard.model.dart';
import 'package:flex_year_tablet/ui/dashboard/widgets/attendance_button.dart';
import 'package:flex_year_tablet/ui/dashboard/widgets/dashboard_drawer.dart';
import 'package:flex_year_tablet/ui/dashboard/widgets/utility_item.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_section.widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
          appBar: AppBar(
            centerTitle: true,
            title: Image.network(
              auBaseURL + model.logo.logoPath,
              width: 150,
              height: 35,
            ),
            bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        formattedDate(model.currentDateTime),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        formattedTime(model.currentDateTime),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              preferredSize: const Size(double.infinity, 20),
            ),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTodaysAttendance(),
                  _buildForgotToCheckout(),
                  _buildUtilities(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForgotToCheckout() {
    return FYSection(
      title: "Forgot To Checkout",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "You forgot to checkout in 2021-11-18. You can not checkout next time until review previous checkout.",
          ),
          const SizedBox(
            height: 10,
          ),
          FYPrimaryButton(
            label: "Checkout Request for 2021-11-18",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysAttendance() {
    return FYSection(
      title: "Today's Attendance",
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: 3.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: const [
          AttendanceButton(
            title: "Check In",
            icon: MdiIcons.clockStart,
            color: Colors.green,
          ),
          AttendanceButton(
            title: "Break In",
            icon: MdiIcons.food,
            color: AppColor.primary,
          ),
          AttendanceButton(
            title: "Check Out",
            icon: MdiIcons.clockEnd,
            color: Colors.green,
          ),
          AttendanceButton(
            title: "Break Out",
            icon: MdiIcons.foodOff,
            color: AppColor.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildUtilities() {
    return FYSection(
      title: "Utilities",
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        shrinkWrap: true,
        crossAxisSpacing: 8,
        children: const [
          UtilityItem(
            title: "Leave Request",
            icon: MdiIcons.shieldAirplaneOutline,
            iconColor: Colors.orange,
          ),
          UtilityItem(
            title: "Report",
            iconColor: Colors.lightGreen,
            icon: MdiIcons.chartBoxOutline,
          ),
          UtilityItem(
            title: "Daily Report",
            iconColor: Colors.lightGreen,
            icon: MdiIcons.chartBoxOutline,
          ),
          UtilityItem(
            title: "Weekly Report",
            iconColor: Colors.lightGreen,
            icon: MdiIcons.chartBoxOutline,
          ),
        ],
      ),
    );
  }
}
