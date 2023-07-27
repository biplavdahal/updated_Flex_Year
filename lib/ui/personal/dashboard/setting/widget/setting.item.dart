import 'dart:collection';
import 'package:flex_year_tablet/ui/personal/dashboard/setting/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:table_calendar/table_calendar.dart';

class CalanderItems extends StatefulWidget {
  final VoidCallback? onTap;

  const CalanderItems({
    Key? key,
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

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
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

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TableCalendar<Event>(
          rowHeight: MediaQuery.of(context).size.height / 23,
          firstDay: DateTime.utc(1990, 10, 16),
          lastDay: DateTime.utc(2080, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          selectedDayPredicate: (day) {
            return _selectedDays.contains(day);
          },
          onDaySelected: _onDaySelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        ElevatedButton(
          child: const Text('Clear selection'),
          onPressed: () {
            setState(() {
              _selectedDays.clear();
              _selectedEvents.value = [];
            });
          },
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
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
