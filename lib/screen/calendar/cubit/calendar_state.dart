part of 'calendar_cubit.dart';

@immutable
class CalendarState {
  final DateTime initialDate;
  final DateTime currentBaseDate;
  CalendarState({required this.initialDate, required this.currentBaseDate});

  CalendarState copyWith({DateTime? currentBaseDate}) {
    return CalendarState(
      initialDate: initialDate,
      currentBaseDate: currentBaseDate ?? this.currentBaseDate,
    );
  }

  factory CalendarState.initial() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, 1);
    return CalendarState(initialDate: firstDate, currentBaseDate: firstDate);
  }
}
