import 'package:bestfriend/bestfriend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory_detail/staff_directory_argument.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory_detail/staff_directory_detaill.viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory_detail/widget/staff_directory_detail.item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../theme.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffDirectoryDetailView extends StatefulWidget {
  static String tag = 'staff-directory-detail-view';

  final Arguments? arguments;
  const StaffDirectoryDetailView(
    this.arguments, {
    Key? key,
  }) : super(key: key);

  @override
  State<StaffDirectoryDetailView> createState() =>
      _StaffDirectoryDetailViewState();
}

class _StaffDirectoryDetailViewState extends State<StaffDirectoryDetailView> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return View<StaffDirectoryDetailViewModel>(
      onModelReady: (model) =>
          model.init(widget.arguments as StaffDirectoryArgument),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.searchParams['search'][0]['department_name']),
          ),
          body: Column(
            children: [
              if (model.isLoading) const FYLinearLoader(),
              if (!model.isLoading)
                SizedBox(
                  height: 75,
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    scrollbarOrientation: ScrollbarOrientation.bottom,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Scrollable(
                            controller: _scrollController,
                            axisDirection: AxisDirection.right,
                            viewportBuilder: (BuildContext context, mode) {
                              return ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: model.details.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 3,
                                ),
                                itemBuilder: (context, index) {
                                  final _report = model.details[index];
                                  return InkWell(
                                    onTap: () {
                                      model.index = index;
                                      setState(() {});
                                    },
                                    child: StaffDirectoryDetailItem(
                                      _report,
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  CircleAvatar(
                    child: model.details[model.index ?? 0].staffPhoto != null
                        ? CachedNetworkImage(
                            imageUrl: auBaseURL +
                                model.details[model.index ?? 0].staffPhoto!,
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                              backgroundColor: AppColor.primary,
                            ),
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: AppColor.primary,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    model.details[model.index ?? 0].firstName
                                        .toString()[0],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    model.details[model.index ?? 0].lastName
                                        .toString()[0],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      model.details[model.index ?? 0].firstName.toString() +
                          "  " +
                          model.details[model.index ?? 0].middleName
                              .toString() +
                          "  " +
                          model.details[model.index ?? 0].lastName.toString(),
                      style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Card(
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          _buildProfileField(
                              context: context,
                              label: "Email Address",
                              value: model
                                  .details[model.index ?? 0].emailAddress
                                  .toString(),
                              icon: MdiIcons.emailBox),
                          _buildProfileField(
                              context: context,
                              label: "Mobile Number",
                              value: model.details[model.index ?? 0].mobile
                                  .toString(),
                              icon: MdiIcons.phone),
                          _buildProfileField(
                              context: context,
                              label: "Gender",
                              value: model.details[model.index ?? 0].gender
                                          .toString() ==
                                      'M'
                                  ? 'Male'
                                  : 'Female',
                              icon: MdiIcons.genderMaleFemaleVariant),
                          _buildProfileField(
                              context: context,
                              label: "Maritual Status",
                              value: model.details[model.index ?? 0]
                                          .maritalStatus
                                          .toString() ==
                                      'M'
                                  ? 'Married'
                                  : 'Unmarried',
                              icon: MdiIcons.accountGroup),
                        ],
                      ),
                    ),
                  )
                ],
              )
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
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            "$label : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (label == "Mobile Number") {
                  _launchPhoneCall(value, context);
                }
              },
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchPhoneCall(
      String phoneNumber, BuildContext context) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch the phone call.'),
        ),
      );
    }
  }
}
