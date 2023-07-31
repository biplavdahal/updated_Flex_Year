import 'package:flex_year_tablet/data_models/present_staff.data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../theme.dart';

class PresentStaffItem extends StatelessWidget {
  final PresentStaffModelData staff;

  PresentStaffItem({Key? key, required this.staff}) : super(key: key);

  final Map<String, Color> _statusColor = {
    "Check In": Colors.green.shade300,
    'Check Out': Colors.red.shade200,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: _statusColor[staff.status] ?? Colors.yellow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              children: [
                Text(
                  staff.staffName + " [" + staff.hours + "]",
                  style: const TextStyle(
                      color: AppColor.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70,
            child: VerticalDivider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 12,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Check In : ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: staff.checkInTime,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Check Out : ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: staff.checkOutTime,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
