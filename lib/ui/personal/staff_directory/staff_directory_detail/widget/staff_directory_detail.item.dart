import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/theme.dart';

import 'package:flutter/material.dart';

import '../../../../../data_models/department_detail_list.data.dart';

class StaffDirectoryDetailItem extends StatelessWidget {
  final DepartmentDetailListdata item;

  const StaffDirectoryDetailItem(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            child: item.staffPhoto != null
                ? CachedNetworkImage(
                    imageUrl: auBaseURL + item.staffPhoto!,
                    errorWidget: (context, url, error) => const CircleAvatar(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            item.firstName.toString()[0],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            item.lastName.toString()[0],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
