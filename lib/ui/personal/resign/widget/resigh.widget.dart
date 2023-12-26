import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flutter/material.dart';

class ResignItem extends StatelessWidget {
  final ResignData resign;

  ResignItem({Key? key, required this.resign}) : super(key: key);

  final Map<String, Color> _statusColor = {
    'Pending': Colors.yellow.shade300,
    'Approved': Colors.green.shade300,
    'Declined': Colors.red.shade200
  };

  @override
  Widget build(BuildContext context) {
    Color statusColor = resign.status != null
        ? _statusColor[resign.status] ?? Colors.grey
        : Colors.grey;
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: statusColor, width: 1),
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
                    child: Text(resign.feedBack.toString() != 'null'
                        ? resign.feedBack.toString()
                        : 'No Feedback')))
          ],
        ));
  }
}
