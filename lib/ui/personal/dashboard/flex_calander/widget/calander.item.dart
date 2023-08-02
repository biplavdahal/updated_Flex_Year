import 'dart:collection';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/flex_calander/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../data_models/attendance_report.data.dart';

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
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;

      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.clear();
        _selectedDays.add(selectedDay);
      }
    });
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
      return Colors.transparent; // Do nothing for dates after today
    } else if (event.weekend.isNotEmpty) {
      return const Color.fromARGB(255, 139, 213, 245);
    } else if (event.holiday != null) {
      return Colors.amber.shade100;
    } else if (event.checkInTime == '00:00' && event.checkOutTime == '00:00') {
      return Colors.red;
    } else if (event.checkInTime == '00:00' || event.checkOutTime == '00:00') {
      return Colors.grey;
    } else {
      return Colors.green.shade300;
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

  @override
  Widget build(BuildContext context) {
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
          calendarStyle: CalendarStyle(
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
              final color = _getEventColor(event, day);
              final isCircleShape = color == Colors.transparent;
              return Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
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
          child: const Text('Clear'),
          onPressed: () {
            setState(() {
              _selectedDays.clear();
              _selectedEvents.value = [];
            });
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
                    child: ListTile(
                      title: Center(
                        child: Text(
                          'Date: ${event.date.toString().substring(0, 10)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Center(
                            child: Text(
                              'Check-In Time: ${event.checkInTime}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const Divider(),
                          Center(
                            child: Text(
                              'Check-Out Time: ${event.checkOutTime}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const Divider(),
                          Center(
                            child: Text(
                              'Total Hours: ${event.grandTotal} Hrs',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

Color _getCardColor(String totalWorkingHours) {
  double hours = double.tryParse(totalWorkingHours) ?? 0.0;
  return hours < 8 ? Colors.red.shade100 : Colors.green.shade100;
}

Color _getTextColor(String totalWorkingHours) {
  double hours = double.tryParse(totalWorkingHours) ?? 0.0;
  return hours > 8 ? Colors.green : Colors.red;
}
