part of 'app_data_bloc.dart';

@immutable
sealed class AppDataBaseState {
  const AppDataBaseState({required this.journalEntryModels, required this.periodModels});
  final List<JournalEntryModel> journalEntryModels;
  final List<PeriodModel> periodModels;
  double estimateAverage(int Function(PeriodModel) fieldSelector) {
    return periodModels.ignoreLast().fold(0, (prev, e) => prev + fieldSelector(e)) /
        periodModels.ignoreLast().length;
  }

  int get estimateCycleLength => estimateAverage((e) => e.cycleLength).round();
  int get estimatePeriodLength => estimateAverage((e) => e.periodLength).round();

  DateTime get estimatedPeriodStartDate =>
      periodModels.last.periodStartDate.add(Duration(days: estimateCycleLength));
  DateTime get estimatedNextPeriodEndDate =>
      estimatedPeriodStartDate.add(Duration(days: estimatePeriodLength));
  int get durationUntilEstimatedPeriod =>
      estimatedPeriodStartDate.difference(DateTime.now().withoutTime).inDays;
}

final class AppDataInitial extends AppDataBaseState {
  const AppDataInitial({required super.journalEntryModels, required super.periodModels});
}

final class AppDataReadyState extends AppDataBaseState {
  const AppDataReadyState({required super.journalEntryModels, required super.periodModels});
}

final class AppDataSelectingDateState extends AppDataReadyState {
  const AppDataSelectingDateState({
    required super.journalEntryModels,
    required super.periodModels,
    required this.currentModel,
  });
  final JournalEntryModel currentModel;
}
