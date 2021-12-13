import 'package:flex_year_tablet/data_models/holiday.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class HolidayItem extends StatelessWidget {
  final HolidayData holiday;

  const HolidayItem(this.holiday, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int daysRemaining =
        DateTime.parse(holiday.date).difference(DateTime.now()).inDays;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
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
                  '${DateTime.parse(holiday.date).year}, ${getMonthStringFromDateString(holiday.date, shortten: true)}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  alignment: Alignment.center,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    holiday.date.split("-")[2],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  weekDayFromDateString(holiday.date),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: VerticalDivider(
              color: Colors.grey.shade300,
              thickness: 0.75,
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
                  Text(
                    holiday.title,
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                      '$daysRemaining day${daysRemaining > 1 ? 's' : ''} remaining'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
