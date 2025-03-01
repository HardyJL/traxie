import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:traxie/theme_colors.dart';

class TraxieCalendar extends StatelessWidget {
  const TraxieCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected: (date, _) {
        // context.push('/flow-tracking', extra: date);
      },
      eventLoader: (_) => [],
      firstDay: DateTime.utc(2016, 10, 16),
      lastDay: DateTime.utc(2100, 3, 14),
      focusedDay: DateTime.now(),
      calendarStyle: CalendarStyle(
        todayTextStyle: const TextStyle(
          color: Colors.black,
        ),
        defaultTextStyle: const TextStyle(
          color: Colors.black,
        ),
        outsideTextStyle: const TextStyle(
          color: Colors.black,
        ),
        markerSizeScale: 1,
        markersAnchor: 1,
        markerDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: TraxieTheme.mainRedTransparent,
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: TraxieTheme.mainBlue,
            width: 3,
          ),
        ),
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
    );
  }
}
