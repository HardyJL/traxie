import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String toReadableString() => DateFormat("dd.MM.yyyy").format(this);
}
