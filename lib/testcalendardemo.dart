import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TestCalendarDemo extends StatelessWidget {
  const TestCalendarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test Calendar Demo'),
        ),
        body: Container(
          width: 300,
          height: 300,
          child: SfCalendar(
            view: CalendarView.week,
          ),
        ),
    );
  }
}