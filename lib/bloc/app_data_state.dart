part of 'app_data_bloc.dart';

class AppDataBaseState {
  AppDataBaseState({required this.journalEntryModels, required this.periodModels});
  final List<JournalEntryModel> journalEntryModels;
  final List<PeriodModel> periodModels;
  int? estimateAverage(int Function(PeriodModel) fieldSelector) {
    if (periodModels.isEmpty) {
      return null;
    }
    return (periodModels.fold(0, (prev, e) => prev + fieldSelector(e)) / periodModels.length)
        .round();
  }

  int? _estimateCycleLength;
  int? get estimateCycleLength => _estimateCycleLength ??= estimateAverage((e) => e.cycleLength);
  int? _estimatePeriodLength;
  int? get estimatePeriodLength => _estimatePeriodLength ??= estimateAverage((e) => e.periodLength);

  DateTime? _estimatedPeriodStartDate;
  DateTime? get estimatedPeriodStartDate =>
      _estimatedPeriodStartDate ??= journalEntryModels.lastPeriodStartDate?.add(
        Duration(days: estimateCycleLength ?? 28),
      );

  DateTime? _estimatedNextPeriodEndDate;
  DateTime? get estimatedNextPeriodEndDate =>
      _estimatedNextPeriodEndDate ??= estimatedPeriodStartDate?.add(
        Duration(days: estimatePeriodLength ?? 6),
      );
  int? _durationUntilEstimatedPeriod;
  int? get durationUntilEstimatedPeriod =>
      _durationUntilEstimatedPeriod ??=
          estimatedPeriodStartDate?.difference(GetIt.I.get<DateTime>()).inDays ?? null;

  List<JournalEntryModel>? _estimatedPeriodsToShow;
  List<JournalEntryModel> estimatedPeriodsToShow() {
    if (_estimatedPeriodsToShow != null) return _estimatedPeriodsToShow!;
    if (estimatedPeriodStartDate == null) return [];
    final List<JournalEntryModel> _journalEntryModels = [];
    for (int month = 0; month <= 12; month++) {
      _journalEntryModels.addAll(
        List<JournalEntryModel>.generate(
          estimatePeriodLength ?? 28,
          (index) => JournalEntryModel(
            trackingDate: estimatedPeriodStartDate!.add(Duration(days: index + 30 * month)).noTime,
            flowStrength: 0,
          ),
        ),
      );
    }
    _estimatedPeriodsToShow = _journalEntryModels;
    return _journalEntryModels;
  }

  Map<DateTime, bool> periodDays = {};

  bool isPeriodDay(DateTime date) {
    if (journalEntryModels.isNotEmpty) return false;
    if (periodDays.keys.contains(date)) return periodDays[date]!;
    final mergedList = journalEntryModels + estimatedPeriodsToShow();
    final isPartOfPeriod = (mergedList).any((element) => element.trackingDate.isSameDate(date));
    periodDays[date] = isPartOfPeriod;
    return isPartOfPeriod;
  }
}

final class AppDataInitial extends AppDataBaseState {
  AppDataInitial({required super.journalEntryModels, required super.periodModels});
}

final class AppDataReadyState extends AppDataBaseState {
  AppDataReadyState({required super.journalEntryModels, required super.periodModels});
}

final class AppDataSelectingDateState extends AppDataReadyState {
  AppDataSelectingDateState({
    required super.journalEntryModels,
    required super.periodModels,
    required this.currentModel,
  });
  final JournalEntryModel currentModel;
}
