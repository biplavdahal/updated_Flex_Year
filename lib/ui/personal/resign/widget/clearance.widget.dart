import 'package:flex_year_tablet/data_models/user_cleareance_data.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../theme.dart';

class ClearanceItem extends StatelessWidget {
  final Clearancedata clearance;
  ClearanceItem({Key? key, required this.clearance}) : super(key: key);

  final Map<String, Color> _statusColor = {
    'Pending': Colors.yellow.shade300,
    'Approved': Colors.green.shade300,
    'Declined': Colors.red.shade200
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: _statusColor[clearance.status] ?? Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  top: 30,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      alignment: Alignment.center,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        clearance.clearanceName.toString(),
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(clearance.types.toString()),
                    // Icon(
                    //   MdiIcons.checkBold,
                    //   color: Colors.yellow,
                    // ),
                    // Icon(
                    //   MdiIcons.checkBold,
                    //   color: Colors.green,
                    // ),
                    // Icon(
                    //   Icons.close,
                    //   color: Colors.red,
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: VerticalDivider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clearance.date.toString(),
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(clearance.status.toString()),
                            Text(' '),
                            if (clearance.status == 'Pending')
                              const Icon(
                                MdiIcons.clockOutline,
                                color: Colors.yellow,
                              ),
                            if (clearance.status == 'Approved')
                              const Icon(
                                MdiIcons.checkBold,
                                color: Colors.green,
                              ),
                            if (clearance.status == 'Declined')
                              const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
