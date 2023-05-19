import 'package:bestfriend/di.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.model.dart';
import 'package:flex_year_tablet/ui/personal/profile/widget/user_profile_header.dart';
import 'package:flex_year_tablet/widgets/fy_user_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../services/authentication.service.dart';

class ProfileView extends StatelessWidget {
  static String tag = 'profile-view';

  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ProfileModel>(
      builder: (ctx, model, child) {
        return Scaffold(
          
          backgroundColor: AppColor.primary,
          
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              PopupMenuButton<String>(
                onSelected: model.moreOptionActions,
                itemBuilder: (context) {
                  return [
                    // const PopupMenuItem<String>(
                    //   value: "update_profile",
                    //   child: Text('Update Profile'),
                    // ),
                    const PopupMenuItem<String>(
                      value: "change_password",
                      child: Text(
                        'Change Password',
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 14),
              UserProfileHeader(),
              const SizedBox(height: 14),
              const SizedBox(height: 14),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                                child: Text(
                              "Information",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ChoiceChip(
                                  label: Text(model.tabs[0]),
                                  selected: model.selectedTab == '0',
                                  labelStyle: TextStyle(
                                    color: model.selectedTab == '0'
                                        ? AppColor.primary
                                        : Colors.black,
                                  ),
                                  onSelected: (_) => model.selectedTab = '0',
                                ),
                                ChoiceChip(
                                  label: Text(model.tabs[1]),
                                  selected: model.selectedTab == '1',
                                  onSelected: (_) => model.selectedTab = '1',
                                  labelStyle: TextStyle(
                                    color: model.selectedTab == '1'
                                        ? AppColor.primary
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            if (model.selectedTab == "0")
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      _buildProfileField(
                                        label: "Mobile",
                                        value: model.user.staff.mobile,
                                        icon: MdiIcons.cellphone,
                                      ),
                                      _buildProfileField(
                                        label: "E-mail",
                                        value: model.user.staff.email,
                                        icon: MdiIcons.emailOutline,
                                      ),
                                      _buildProfileField(
                                        label: "Address",
                                        value: model.user.staffAddresses.isEmpty
                                            ? "N/A"
                                            : model.user.staffAddresses[0]
                                                .addressLine1,
                                        icon: MdiIcons.mapMarkerOutline,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (model.selectedTab == "1")
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      _buildProfileField(
                                          label: "Hire Date",
                                          value: model.user.staff.hireDate
                                              .toString(),
                                          icon: Icons.date_range),
                                      _buildProfileField(
                                          label: "Remaining Leave Days",
                                          value: model.user.staff.remainingLeave
                                              .toString(),
                                          icon: MdiIcons.shieldAirplaneOutline),
                                      // _buildProfileField(
                                      //     label: "Normal Salary Rate",
                                      //     value: model
                                      //         .user.staff.normalSalaryRate
                                      //         .toString(),
                                      //     icon: MdiIcons.cashCheck),
                                      _buildProfileField(
                                          label: "Sick Leave",
                                          value: model.user.staff.sickLeave
                                              .toString(),
                                          icon: MdiIcons.cashCheck),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ))),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Text(
            "$label : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
