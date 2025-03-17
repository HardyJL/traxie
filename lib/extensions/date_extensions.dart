import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String toReadableString() => DateFormat("dd.MM.yyyy").format(this);

  String toMonthFullName() => DateFormat("MMMM").format(this);
  String toDayFullName(int dayOfWeek) =>
      DateFormat("EEEE").format(DateTime(this.year, this.month, dayOfWeek));
}
