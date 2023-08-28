import 'package:flex_year_tablet/data_models/notification.data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../theme.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData data;
  const NotificationItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        MdiIcons.calendar,
                        color: AppColor.secondaryTextColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        data.date,
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
                    data.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(data.detailsm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
