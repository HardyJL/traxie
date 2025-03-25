part of 'app_data_bloc.dart';

class AppDataBaseState {
  AppDataBaseState({required this.journalEntryModels, required this.periodModels});
  final List<JournalEntryModel> journalEntryModels;
  final List<PeriodModel> periodModels;
  double? _estimateAverage;
  double estimateAverage(int Function(PeriodModel) fieldSelector) =>
      _estimateAverage ??=
          periodModels.fold(0, (prev, e) => prev + fieldSelector(e)) / periodModels.length;

  int? _estimateCycleLength;
  int get estimateCycleLength =>
      _estimateCycleLength ??= estimateAverage((e) => e.cycleLength).round();
  int? _estimatePeriodLength;
  int get estimatePeriodLength =>
      _estimatePeriodLength ??= estimateAverage((e) => e.periodLength).round();

  DateTime? _estimatedPeriodStartDate;
  DateTime? get estimatedPeriodStartDate =>
      _estimatedPeriodStartDate ??= journalEntryModels.lastPeriodStartDate?.add(
        Duration(days: estimateCycleLength),
      );

  DateTime? _estimatedNextPeriodEndDate;
  DateTime? get estimatedNextPeriodEndDate =>
      _estimatedNextPeriodEndDate ??= estimatedPeriodStartDate?.add(
        Duration(days: estimatePeriodLength),
      );
  int? _durationUntilEstimatedPeriod;
  int get durationUntilEstimatedPeriod =>
      _durationUntilEstimatedPeriod ??=
          estimatedPeriodStartDate?.difference(GetIt.I.get<DateTime>()).inDays ?? 0;
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
