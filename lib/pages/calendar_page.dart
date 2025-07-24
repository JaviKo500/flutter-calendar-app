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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDate,
            currentDay: _selectedDate,
            eventLoader: (day) {
              print('eventLoader day: $day');
              return [
                DateTime(day.year, day.month, day.day, 12, 0),
              ];
            },
            onDaySelected: (selectedDay, focusedDay) {
              print('selectedDay: $selectedDay, focusedDay: $focusedDay');
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            onPageChanged: (focusedDay) {
              print('onPageChanged focusedDay: $focusedDay');
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          )
        ],
      ),
    );
  }
}