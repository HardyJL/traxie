import 'package:hive/hive.dart';
import 'package:traxie/extensions/date_extensions.dart';

part 'period_model.g.dart';

@HiveType(typeId: 10)
class PeriodModel extends HiveObject implements Comparable<PeriodModel> {
  PeriodModel({
    required this.cycleLength,
    required this.periodLength,
    required this.periodStartDate,
    required this.periodEndDate,
  });

  @HiveField(11, defaultValue: 6)
  final int periodLength;
  @HiveField(12, defaultValue: 28)
  final int cycleLength;
  @HiveField(13)
  final DateTime periodStartDate;
  @HiveField(14)
  final DateTime periodEndDate;

  @override
  String toString() {
    return 'PeriodModel(periodStartDate: $periodStartDate, periodEndDate: $periodEndDate, cycleLength: $cycleLength, periodLength: $periodLength)';
  }

  @override
  int compareTo(PeriodModel other) {
    return this.periodStartDate.noTime.compareTo(other.periodStartDate.noTime);
  }
}
