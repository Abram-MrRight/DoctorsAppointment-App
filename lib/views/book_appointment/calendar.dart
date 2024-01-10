
import 'package:table_calendar/table_calendar.dart';

import '../../consts/consts.dart';
import '../../controllers/myAppointment_controller.dart';

class MyCalendar extends StatefulWidget {
  final MyAppointmentController controller;

  const MyCalendar({
    super.key,
    required this.controller
  });

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
    widget.controller.appointmentDayController.text = _selectedDay.toString().substring(0, 10);
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          widget.controller.appointmentDayController.text = _selectedDay.toString().substring(0, 10);
          _focusedDay = focusedDay;
        });
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: true, // Hide the format button
        titleCentered: true,
        formatButtonTextStyle: const TextStyle().copyWith(color: Colors.white),
        formatButtonDecoration: BoxDecoration(
          color: AppColors.blueTheme,
          borderRadius: BorderRadius.circular(16.0),
        ),
        formatButtonShowsNext: true,
        titleTextStyle: const TextStyle(fontSize: 18.0),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColors.blueColor.withOpacity(.5),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.blueTheme,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}