import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  DateTime get noTime => DateTime(year, month, day);
  String get asReadableString => DateFormat("dd.MM.yyyy").format(this);

  bool isSameDate(DateTime date) {
    return day == date.day && month == date.month && year == date.year;
  }

  String toMonthFullName() => DateFormat("MMMM").format(this);
  String toDayFullName(int dayOfWeek) =>
      DateFormat("EEEE").format(DateTime(this.year, this.month, dayOfWeek));
  bool isDayAfter(DateTime lastDate) {
    if(this.difference(lastDate).inDays <= 1) return true;
    return false;
  }
}
