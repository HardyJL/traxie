import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          //  PaddyCalendar(),
          // CalendarDatePicker(
          //   initialDate: DateTime.now(),
          //   firstDate: DateTime(2000),
          //   lastDate: DateTime(2100),
          //   onDateChanged: (date) {
          //     context.push('/flow-tracking', extra: date);
          //   },
          // ),
        ],
      ),
    );
  }
}
