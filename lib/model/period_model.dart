import 'package:hive/hive.dart';

part 'period_model.g.dart';

@HiveType(typeId: 1)
class PeriodModel extends HiveObject {

  PeriodModel({
    required this.cycleLength,
    required this.periodLength,
    required this.periodStartDate,
    required this.periodEndDate,
  });

  @HiveField(0)
  final int periodLength;
  @HiveField(1)
  final int cycleLength;
  @HiveField(2)
  final DateTime periodStartDate;
  @HiveField(3)
  final DateTime periodEndDate;

  @override
  String toString() {
    return 'PeriodModel(periodStartDate: $periodStartDate, periodEndDate: $periodEndDate, cycleLength: $cycleLength, periodLength: $periodLength)';
  }
}
