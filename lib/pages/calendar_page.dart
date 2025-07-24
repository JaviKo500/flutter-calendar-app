import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarPage extends StatefulWidget {

  const CalendarPage ({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List< Event > _events = [
    Event(title: 'Event 1', date: DateTime.utc(2025, 7, 16)),
    Event(title: 'Event 2', date: DateTime.utc(2025, 7, 17)),
    Event(title: 'Event 2.5', date: DateTime.utc(2025, 7, 17)),
    Event(title: 'Event 2.6', date: DateTime.utc(2025, 7, 17)),
    Event(title: 'Event 3', date: DateTime.utc(2025, 7, 18)),
    Event(title: 'Event 4', date: DateTime.utc(2025, 7, 19)),
    Event(title: 'Event 5', date: DateTime.utc(2025, 7, 20)),
  ];

  List< Event > eventsSelected = [];

  List<Event> _getEventsForDay(DateTime day) {
    List< Event >  eventsForDay = [];
    for (Event event in _events) {

      final DateTime emitDate = event.date;
      
      if (isSameDay(day, emitDate)) {
        eventsForDay.add(Event(
          title: event.title,
          date: emitDate,
        ));
      }
    }
    return eventsForDay;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDate,
            currentDay: _selectedDate,
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              print('selectedDay: $selectedDay, focusedDay: $focusedDay');
              if (!isSameDay(_selectedDate, selectedDay)) {
                setState(() {
                  _selectedDate = selectedDay;
                  eventsSelected = _getEventsForDay(selectedDay);
                });
              }
            },
            onPageChanged: (focusedDay) {
              print('focusedDay: $focusedDay');
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (_getEventsForDay(day).isEmpty) return null;
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        width:16.0,
                        height: 16.0,
                        alignment: Alignment.center,
                        child: Text('${_getEventsForDay(day).length}', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ), ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ...eventsSelected.map((event) => Card(
            margin: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(event.title),
                  ),
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }
}
class Event {
  final String title;
  final DateTime date;

  Event({required this.title, required this.date});
}