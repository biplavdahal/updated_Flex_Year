import 'dart:collection';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/flex_calander/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../data_models/attendance_report.data.dart';
import '../../../../../helper/date_time_formatter.helper.dart';

class CalanderItems extends StatefulWidget {
  final List<AttendanceReportData> monthlyReport;
  final VoidCallback? onTap;

  const CalanderItems({
    Key? key,
    required this.monthlyReport,
    this.onTap,
  }) : super(key: key);

  @override
  State<CalanderItems> createState() => _CalanderItemsState();
}

class _CalanderItemsState extends State<CalanderItems> {
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    _selectedDays.add(DateTime.now());
    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  void dispose() {
    _selectedDays.add(DateTime.now());
    _selectedEvents.value = _getEventsForDays(_selectedDays);
    super.dispose();
  }

  Map<DateTime, List<Event>> _createEventsMap(List<AttendanceReportData> data) {
    final eventsMap = <DateTime, List<Event>>{};
    for (final report in data) {
      final date = DateTime.parse(report.date);
      final event = Event(
          date: date,
          checkInTime: report.checkInTime,
          checkOutTime: report.checkOutTime,
          holiday: report.holiday,
          weekend: report.weekend,
          grandTotal: report.totalWorkingHours);
      eventsMap[date] = [event];
    }
    return eventsMap;
  }

  Color _getEventColor(Event event, DateTime date) {
    final isDateAfterToday = date.isAfter(DateTime.now());
    if (isDateAfterToday) {
      return Colors.transparent;
    } else if (event.weekend.isNotEmpty) {
      return const Color.fromARGB(255, 139, 213, 245);
    } else if (event.holiday != null) {
      return Colors.amber.shade200;
    } else if (event.checkInTime == '00:00' && event.checkOutTime == '00:00') {
      return Colors.red.shade300;
    } else if (event.checkInTime == '00:00' || event.checkOutTime == '00:00') {
      return Colors.grey;
    } else {
      return Colors.green.shade300;
    }
  }

  BoxShape _getEventShape(Color color) {
    if (color == Colors.transparent) {
      return BoxShape.circle;
    } else {
      return BoxShape.rectangle;
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return widget.monthlyReport
        .where((report) => isSameDay(DateTime.parse(report.date), day))
        .map((report) => Event(
              date: DateTime.parse(report.date),
              checkInTime: report.checkInTime,
              checkOutTime: report.checkOutTime,
              holiday: report.holiday,
              weekend: report.weekend,
              grandTotal: report.totalWorkingHours,
            ))
        .toList();
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    final List<Event> events = [];
    for (final day in days) {
      final dayEvents = _getEventsForDay(day);
      events.addAll(dayEvents);
    }
    return events;
  }

  void _goToToday() {
    setState(() {
      _focusedDay = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    String getDayAndMonth(DateTime date) {
      final day = date.day.toString();
      final month = getMonthStringFromDateString(
        date.toString(),
      );
      return '$day, $month';
    }

    final eventsMap = _createEventsMap(widget.monthlyReport);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TableCalendar<Event>(
          rowHeight: 35,
          firstDay: DateTime.utc(1990, 10, 16),
          lastDay: DateTime.utc(2080, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          availableGestures: AvailableGestures.none,
          calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
              selectedTextStyle: const TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(5)),
              defaultDecoration: BoxDecoration(
                  color: AppColor.accent,
                  borderRadius: BorderRadius.circular(5))),
          eventLoader: (day) => eventsMap[day] ?? [],
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, day, focusedDay) {
            final events = _getEventsForDays({day});

            if (events.isNotEmpty) {
              final event = events.first;
              final isDateAfterToday = day.isAfter(DateTime.now());
              final color = isDateAfterToday
                  ? Colors.transparent
                  : _getEventColor(event, day);
              if (color == Colors.transparent) {
                return Container();
              }

              if (color == Colors.transparent) {
                return Container();
              }
              final isCircleShape = _getEventShape(color) == BoxShape.circle;
              return Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: _getEventShape(color),
                  borderRadius:
                      isCircleShape ? null : BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
          headerStyle: HeaderStyle(
              titleTextFormatter: (date, _) => DateFormat.yMMMM().format(date),
              titleCentered: true,
              formatButtonVisible: false,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              formatButtonTextStyle: const TextStyle(color: Colors.white)),
          selectedDayPredicate: (day) {
            return _selectedDays.contains(day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
              if (_selectedDays.contains(selectedDay)) {
                _selectedDays.remove(selectedDay);
              } else {
                _selectedDays.clear();
                _selectedDays.add(selectedDay);
              }
            });
            _selectedEvents.value = _getEventsForDays(_selectedDays);
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
        ),
        const SizedBox(
          height: 12,
        ),
        ElevatedButton(
          child: const Text('Today'),
          onPressed: () {
            _goToToday();
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final event = value[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0,
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
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        DateFormat('MMMM y', 'en_US')
                                            .format(event.date),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        DateFormat('dd', 'en_US')
                                            .format(event.date),
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
                                        getWeekdayStringFromDate(event.date),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )),
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
                                    _getSelectedDayText(event.date),
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
                                  'Check-In Time : ' + event.checkInTime,
                                  style: const TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Check-Out Time : ' + event.checkOutTime,
                                  style: const TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Total Hrs : ${event.grandTotal} Hrs',
                                  style: TextStyle(
                                    color: double.parse(event.grandTotal) < 8.0
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String getWeekdayStringFromDate(DateTime date) {
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[date.weekday - 1];
  }

  String _getSelectedDayText(DateTime selectedDate) {
    final today = DateTime.now();
    final difference = selectedDate.difference(today).inDays;
    if (difference == 0) {
      return 'Today';
    } else if (difference < 0) {
      return '${difference.abs()} Day${difference.abs() == 1 ? '' : 's'} Ago';
    } else {
      return '$difference Day${difference == 1 ? '' : 's'} After';
    }
  }
}
