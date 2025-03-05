part of 'app_data_bloc.dart';

@immutable
sealed class AppDataBaseState {
  const AppDataBaseState({
    required this.journalEntryModels,
    required this.periodModels,
    this.estimateCycleLength = 28,
    this.estimatePeriodLength = 5,
  });
  final List<JournalEntryModel> journalEntryModels;
  final List<PeriodModel> periodModels;
  final int estimateCycleLength;
  final int estimatePeriodLength;

  DateTime get estimatedPeriodStartDate => periodModels.last.periodStartDate
      .add(Duration(days: estimateCycleLength));
  DateTime get estimatedNextPeriodEndDate =>
      estimatedPeriodStartDate.add(Duration(days: estimatePeriodLength));
  int get durationUntilEstimatedPeriod =>
      estimatedPeriodStartDate.difference(DateTime.now().withoutTime).inDays;

  List<String> generateEventsForTracking(DateTime day) {
    if (journalEntryModels.any((e) => e.trackingDate == day.withoutTime)) {
      return [''];
    }
    return [];
  }
}

final class AppDataInitial extends AppDataBaseState {
  const AppDataInitial({
    required super.journalEntryModels,
    required super.periodModels,
  });
}

final class AppDataReadyState extends AppDataBaseState {
  const AppDataReadyState({
    required super.journalEntryModels,
    required super.periodModels,
  });
}

final class AppDataSelectingDateState extends AppDataReadyState {
  const AppDataSelectingDateState({
    required super.journalEntryModels,
    required super.periodModels,
    required this.currentModel,
  });
  final JournalEntryModel currentModel;
}
