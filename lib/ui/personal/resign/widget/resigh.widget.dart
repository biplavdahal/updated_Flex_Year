import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../theme.dart';

class ResignItem extends StatelessWidget {
  final ResignData resign;

  const ResignItem({Key? key, required this.resign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        onTap: () {},
                        child: Icon(Icons.edit, color: AppColor.primary),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
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
                        : 'No Feedback')))
          ],
        ));
  }
}
