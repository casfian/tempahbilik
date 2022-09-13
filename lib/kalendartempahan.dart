import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class KalendarTempahan extends StatelessWidget {
  const KalendarTempahan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalendar Tempahan'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
      ),
    );
  }
}
