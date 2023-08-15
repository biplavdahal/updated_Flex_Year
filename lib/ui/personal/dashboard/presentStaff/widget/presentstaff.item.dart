import 'package:flex_year_tablet/data_models/present_staff.data.dart';
import 'package:flutter/material.dart';
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
    double calculateTotalHours(String time) {
      final List<String> timeParts = time.split(':');
      final int hours = int.parse(timeParts[0]);
      final int minutes = int.parse(timeParts[1]);
      return hours + (minutes / 60);
    }

    const double maxHours = 8.5;
    final double totalHours = calculateTotalHours(staff.hours);
    final double percentage = totalHours / maxHours;

    final Color startColor = Colors.yellow.shade700;
    final Color endColor = Colors.green.shade300;
    final List<Color> colors = [startColor, endColor];
    final List<double> stops = [0.0, percentage];

    Color getBorderColor() {
      if (percentage >= 0.0 && percentage <= 1.0) {
        final int red = ((1 - percentage) * 255).toInt();
        final int green = (percentage * 255).toInt();
        return Color.fromARGB(255, red, green, 0);
      }
      return Colors.yellow.shade700;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: getBorderColor(),
            width: 1.5,
          ),
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
                        text: staff.status,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.check_circle_sharp,
                                color: Colors.green,
                                size: 15,
                              ))
                            ],
                            text: '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          TextSpan(
                            text: ":  " + staff.checkInTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: getUpdatedStatusText(staff.status),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.outbound,
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                            ],
                            text: '',
                          ),
                          TextSpan(
                            text: ":  " + staff.checkOutTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
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
      ),
    );
  }

  String getUpdatedStatusText(String originalStatus) {
    switch (originalStatus) {
      case 'Check In':
        return 'Check Out';
      case 'Onsite In':
        return 'Onsite Out';
      case 'Lunch In':
        return 'Lunch Out';
      default:
        return originalStatus;
    }
  }
}
