import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/colors.dart';
import '../constants/compound_data.dart';

class MyCalendar extends StatefulWidget {
  MyCalendar({super.key, required Null Function(dynamic selectedDay, dynamic focusedDay) onDateSelected});

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    inputControllers['date']!.text = _selectedDay.toString().substring(0, 10);
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 180)),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          inputControllers['date']!.text = _selectedDay.toString().substring(0, 10);
          _focusedDay = focusedDay;
        });
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        titleCentered: true,
        formatButtonTextStyle: const TextStyle().copyWith(color: Colors.white),
        formatButtonDecoration: BoxDecoration(
          color: blueTheme,
          borderRadius: BorderRadius.circular(16.0),
        ),
        formatButtonShowsNext: true,
        titleTextStyle: const TextStyle(fontSize: 18.0),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue.withOpacity(.5),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: blueTheme,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}