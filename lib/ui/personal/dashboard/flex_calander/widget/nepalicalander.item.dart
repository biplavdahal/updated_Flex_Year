import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data_models/attendance_report.data.dart';
import '../../../../../theme.dart';

class NepaliCalanderItems extends StatefulWidget {
  final List<AttendanceReportData> monthlyReport;

  const NepaliCalanderItems({
    Key? key,
    required this.monthlyReport,
  }) : super(key: key);

  @override
  State<NepaliCalanderItems> createState() => _NepaliCalanderItemsState();
}

class _NepaliCalanderItemsState extends State<NepaliCalanderItems> {
  TextEditingController _textFieldController = TextEditingController();
  DateTime? selectedDate;
  String selectedCheckInTime = '';
  String selectedCheckOutTime = '';
  double selectedTotalHours = 0.0;
  String selectedTodayDate = '';
  @override
  Widget build(BuildContext context) {
    final NepaliCalendarController _nepaliCalendarController =
        NepaliCalendarController();
    return Column(
      children: [
        CleanNepaliCalendar(
          controller: _nepaliCalendarController,
          headerDayType: HeaderDayType.halfName,
          initialDate: NepaliDateTime.now(),
          calendarStyle: const CalendarStyle(selectedColor: AppColor.primary),
          dateCellBuilder: cellBuilder,
        ),
        const Divider(),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 16, bottom: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Text(
                            NepaliDateFormat.MMMM()
                                .format(NepaliDateTime.now()),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '18',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'wednesday',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
                child: VerticalDivider(
                  color: AppColor.primary,
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'week',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Text(
                        'Check-In Time : ' + selectedCheckInTime,
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Check-Out Time : ' + selectedCheckOutTime,
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Text(
                        'Total Hrs : ${selectedTotalHours} Hrs',
                        style: TextStyle(
                          color: selectedTotalHours < 8.0
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget cellBuilder(isToday, isSelected, isDisabled, nepaliDate, label, text,
      calendarStyle, isWeekend) {
    String nepaliDateString = NepaliDateFormat('yyyy-MM-dd').format(nepaliDate);

    final reportData = widget.monthlyReport.firstWhere(
      (report) => report.nepaliDate == nepaliDateString,
      orElse: () => AttendanceReportData.empty(),
    );

    Color? cellColor;
    Decoration? cellDecoration;

    if (reportData.holiday != null) {
      cellColor = Colors.yellow;
    } else if (reportData.weekend.isNotEmpty) {
      cellColor = Colors.blue;
    } else if (reportData.checkInTime == '00:00' &&
        reportData.checkOutTime == '00:00') {
      cellColor = Colors.red;
    } else {
      cellColor = Colors.green;
    }

    bool isFutureDate =
        nepaliDate.toDateTime().isAfter(NepaliDateTime.now().toDateTime());
    if (isFutureDate && reportData.holiday == null) {
      cellColor = Colors.white;
    }
    cellDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isSelected ? calendarStyle.selectedColor : Colors.transparent,
      ),
      color: isSelected && isToday
          ? AppColor.primary
          : isToday && calendarStyle.highlightToday
              ? AppColor.primary
              : cellColor,
    );

    return GestureDetector(
      onTap: () {
        updateTextField(reportData);
      },
      child: Padding(
        padding: const EdgeInsets.all(01),
        child: AnimatedContainer(
          padding: const EdgeInsets.all(3),
          duration: const Duration(milliseconds: 2000),
          decoration: cellDecoration,
          child: Center(
            child: Column(
              children: [
                Text(
                  text,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    nepaliDate.toDateTime().day.toString(),
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTextField(AttendanceReportData reportData) {
    setState(() {
      selectedCheckInTime = reportData.checkInTime;
      selectedCheckOutTime = reportData.checkOutTime;
      selectedTotalHours = double.parse(reportData.totalWorkingHours);
      selectedTodayDate = reportData.nepaliDate;
    });
  }
}
