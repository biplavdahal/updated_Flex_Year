import 'package:bestfriend/di.dart';
import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flex_year_tablet/ui/personal/resign/clearance/clearance.view.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../theme.dart';

class ResignItem extends StatelessWidget {
  final ResignData resign;
  final ValueSetter<ResignData>? onEditTap;
  final bool isBusy;

  const ResignItem({
    Key? key,
    required this.resign,
    this.onEditTap,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        absorbing: isBusy,
        child: AnimatedOpacity(
          opacity: isBusy ? 0.5 : 1,
          duration: const Duration(milliseconds: 300),
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            resign.date.toString(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              onEditTap?.call(resign);
                            },
                            child:
                                const Icon(Icons.edit, color: AppColor.primary),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              MdiIcons.delete,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(resign.letter.toString())),
                const Divider(),
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(resign.feedBack.toString() != '' &&
                                resign.feedBack.toString() != 'null'
                            ? resign.feedBack.toString()
                            : 'No Feedback'))),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    locator<ResignViewModel>().goto(ClearanceView.tag);
                  },
                  child: const Text(
                    '  Click to view your resignation status --->',
                    style: TextStyle(color: AppColor.primary),
                  ),
                ),
                const Divider()
              ],
            ),
          ),
        ));
  }
}
