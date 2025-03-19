import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/screen/calendar/cubit/calendar_cubit.dart';
import 'package:traxie/theme_colors.dart';

class TraxieCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalendarCubit>();
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => cubit.ChangeMonth(),
                  ),
                  Text(
                    '${(state.currentBaseDate.toMonthFullName())} ${state.currentBaseDate.year}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => cubit.ChangeMonth(forward: true),
                  ),
                ],
              ),
            ),
            WeekdayHeader(),
            CalendarGrid(
              currentBaseState: state,
              models: context.read<AppDataBloc>().state.journalEntryModels,
              cubit: cubit,
            ),
          ],
        );
      },
    );
  }
}

class WeekdayHeader extends StatelessWidget {
  final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            weekdays
                .map(
                  (day) => SizedBox(
                    width: 40,
                    child: Text(
                      day,
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class CalendarGrid extends StatelessWidget {
  CalendarGrid({super.key, required this.currentBaseState, this.models, required this.cubit});

  final CalendarCubit cubit;
  final CalendarState currentBaseState;
  final List<JournalEntryModel>? models;
  // // Get the first day of the month

  Widget _buildDayCell(
    int day,
    DateTime date, {
    List<JournalEntryModel>? models = null,
    required bool isCurrentMonth,
    required BuildContext ctx,
  }) {
    final isPeriodDay =
        models != null ? models.any((e) => e.trackingDate.isAtSameMomentAs(date)) : false;

    final isToday = date.compareWithoutTime(DateTime.now());

    return GestureDetector(
      onTap:
          () => ctx.read<AppDataBloc>().add(AppDataTrackingChangedPressedEvent(trackingDate: date)),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPeriodDay ? TraxieTheme.mainRedTransparent : Colors.transparent,
          border: isToday ? Border.all(color: Colors.grey, width: 1) : null,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              color: isCurrentMonth ? Colors.black : Colors.grey,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = currentBaseState.currentBaseDate.withoutTime;
    // Calculate offset to start the calendar (considering Monday s the first day of the week)

    // Get the number of days in the month
    final daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    // Calculate the number of days from the previous month to display
    final daysFromPreviousMonth = currentDate.weekday - 1;

    // Calculate days from next month to display to complete the grid
    final totalDaysToDisplay = (daysFromPreviousMonth + daysInMonth + 6) ~/ 7 * 7;
    final daysFromNextMonth = totalDaysToDisplay - daysFromPreviousMonth - daysInMonth;

    // Build the list of day widgets
    List<Widget> dayWidgets = [];

    // Previous month days
    final previousMonth = DateTime(currentDate.year, currentDate.month - 1);
    final daysInPreviousMonth = DateTime(currentDate.year, currentDate.month, 0).day;

    for (int i = 0; i < daysFromPreviousMonth; i++) {
      final day = daysInPreviousMonth - daysFromPreviousMonth + i + 1;
      dayWidgets.add(
        _buildDayCell(
          day,
          DateTime(previousMonth.year, previousMonth.month, day),
          isCurrentMonth: false,
          ctx: context,
        ),
      );
    }

    // Current month days
    for (int i = 1; i <= daysInMonth; i++) {
      dayWidgets.add(
        _buildDayCell(
          i,
          DateTime(currentDate.year, currentDate.month, i),
          isCurrentMonth: true,
          models: models,
          ctx: context,
        ),
      );
    }

    // Next month days
    final nextMonth = DateTime(currentDate.year, currentDate.month + 1);

    for (int i = 1; i <= daysFromNextMonth; i++) {
      dayWidgets.add(
        _buildDayCell(
          i,
          DateTime(nextMonth.year, nextMonth.month, i),
          isCurrentMonth: false,
          ctx: context,
        ),
      );
    }

    // Build the grid with 7 columns
    List<Widget> rows = [];
    for (int i = 0; i < dayWidgets.length; i += 7) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: dayWidgets.sublist(i, i + 7),
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}
