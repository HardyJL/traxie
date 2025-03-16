import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/theme_colors.dart';

class TraxieCalendar extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const TraxieCalendar({Key? key, this.onDateSelected}) : super(key: key);

  @override
  State<TraxieCalendar> createState() => _TraxieCalendarState();
}

class _TraxieCalendarState extends State<TraxieCalendar> {
  final initialDate = DateTime.now();
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(initialDate.year, initialDate.month);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.chevron_left), onPressed: _previousMonth),
              Text(
                '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(icon: const Icon(Icons.chevron_right), onPressed: _nextMonth),
            ],
          ),
        ),

        _buildWeekdayHeader(),
        _buildCalendarGrid(models: bloc.state.journalEntryModels),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

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

  Widget _buildCalendarGrid({List<JournalEntryModel>? models = null}) {
    // Get the first day of the month
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);

    // Calculate offset to start the calendar (considering Monday as the first day of the week)
    int firstWeekdayOfMonth = firstDayOfMonth.weekday;

    // Get the number of days in the month
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    // Calculate the number of days from the previous month to display
    final daysFromPreviousMonth = firstWeekdayOfMonth - 1;

    // Calculate days from next month to display to complete the grid
    final totalDaysToDisplay = (daysFromPreviousMonth + daysInMonth + 6) ~/ 7 * 7;
    final daysFromNextMonth = totalDaysToDisplay - daysFromPreviousMonth - daysInMonth;

    // Build the list of day widgets
    List<Widget> dayWidgets = [];

    // Previous month days
    final previousMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    final daysInPreviousMonth = DateTime(_currentMonth.year, _currentMonth.month, 0).day;

    for (int i = 0; i < daysFromPreviousMonth; i++) {
      final day = daysInPreviousMonth - daysFromPreviousMonth + i + 1;
      dayWidgets.add(
        _buildDayCell(
          day,
          DateTime(previousMonth.year, previousMonth.month, day),
          isCurrentMonth: false,
        ),
      );
    }

    // Current month days
    for (int i = 1; i <= daysInMonth; i++) {
      dayWidgets.add(
        _buildDayCell(
          i,
          DateTime(_currentMonth.year, _currentMonth.month, i),
          isCurrentMonth: true,
          models: models,
        ),
      );
    }

    // Next month days
    final nextMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);

    for (int i = 1; i <= daysFromNextMonth; i++) {
      dayWidgets.add(
        _buildDayCell(i, DateTime(nextMonth.year, nextMonth.month, i), isCurrentMonth: false),
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

  Widget _buildDayCell(
    int day,
    DateTime date, {
    List<JournalEntryModel>? models = null,
    required bool isCurrentMonth,
  }) {
    final isPeriodDay =
        models != null ? models.any((e) => e.trackingDate.isAtSameMomentAs(date)) : false;

    final isToday =
        date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

    return GestureDetector(
      onTap: () {
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(date);
        }
      },
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

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }
}
