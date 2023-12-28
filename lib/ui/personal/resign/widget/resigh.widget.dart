import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flutter/material.dart';

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
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(resign.date.toString() != 'null'
                        ? resign.date.toString()
                        : 'No Date Selected'),
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
