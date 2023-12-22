import 'package:flex_year_tablet/data_models/user_resign.data.dart';
import 'package:flutter/material.dart';

class ResignItem extends StatelessWidget {
  final ResignData resign;

  ResignItem({Key? key, required this.resign}) : super(key: key);

  final Map<String, Color> _statusColor = {
    'pending': Colors.yellow.shade300,
    'approved': Colors.green.shade300,
    'declined': Colors.red.shade200
  };

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: _statusColor[resign.status] ?? Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                        resign.firstName ?? '' + resign.lastName.toString()),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Text(resign.letter ?? 'N/A'),
            )
          ],
        ));
  }
}
