// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:traxie/bloc/app_data_bloc.dart';
// import 'package:traxie/theme_colors.dart';
//
// class TraxieCalendar extends StatelessWidget {
//   const TraxieCalendar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<AppDataBloc>();
//     return TableCalendar(
//       onDaySelected: (date, _) {
//         bloc.add(AppDataTrackingChangedPressedEvent(trackingDate: date));
//       },
//       eventLoader: bloc.state.generateEventsForTracking,
//       firstDay: DateTime.utc(2016, 10, 16),
//       lastDay: DateTime.utc(2100, 3, 14),
//       focusedDay: DateTime.now(),
//       calendarStyle: CalendarStyle(
//         todayTextStyle: const TextStyle(color: Colors.black),
//         defaultTextStyle: const TextStyle(color: Colors.black),
//         outsideTextStyle: const TextStyle(color: Colors.black),
//         markerSizeScale: 1,
//         markersAnchor: 1,
//         markerDecoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           color: TraxieTheme.mainRedTransparent,
//         ),
//         todayDecoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: TraxieTheme.mainBlue, width: 3),
//         ),
//       ),
//       startingDayOfWeek: StartingDayOfWeek.monday,
//     );
//   }
// }
