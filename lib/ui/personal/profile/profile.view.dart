import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/profile/profile.model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 14),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 42,
                child: Text(
                  model.user.staff.firstName[0],
                  style: const TextStyle(
                    fontSize: 42,
                    color: AppColor.primary,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "[EMP - ${model.user.staff.empId}] ${model.user.staff.firstName} ${model.user.staff.lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Expanded(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
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
                            : model.user.staffAddresses[0].addressLine1,
                        icon: MdiIcons.mapMarkerOutline,
                      ),
                    ],
                  ),
                ),
              )),
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
