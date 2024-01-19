import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../data_models/all_staff_birthday.data.dart';
import '../../../../theme.dart';

class BirthdayItem extends StatelessWidget {
  final AllStaffBirthdayData birthdayData;
  const BirthdayItem({Key? key, required this.birthdayData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                       Icons.calendar_month,
                        color: AppColor.secondaryTextColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        birthdayData.dob.toString().substring(5),
                        style: const TextStyle(
                          color: AppColor.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    birthdayData.firstName.toString() +
                        " " +
                        birthdayData.middleName.toString() +
                        " " +
                        birthdayData.lastName.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: AppColor.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    birthdayData.remainingDays.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: 70,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: birthdayData.staffPhoto != null
                    ? CachedNetworkImage(
                        imageUrl: auBaseURL + birthdayData.staffPhoto!,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(),
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                          color: AppColor.primary,
                          strokeWidth: 2,
                        )),
                      )
                    : const Image(
                        image: AssetImage('assets/images/avatar.png')),
              ),
              Container(
                width: 70,
                height: 80,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.center,
                      colors: [
                        Colors.white10,
                      ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
