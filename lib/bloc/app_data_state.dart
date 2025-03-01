part of 'app_data_bloc.dart';

@immutable
sealed class AppDataBaseState {
  const AppDataBaseState(this.journalEntryModels, this.periodModels);
  final List<JournalEntryModel> journalEntryModels;
  final List<PeriodModel> periodModels;
}

final class AppDataInitial extends AppDataBaseState {
const  AppDataInitial(super.journalEntryModels, super.periodModels);
}

final class AppDataReadyState extends AppDataBaseState {
const  AppDataReadyState(super.journalEntryModels, super.periodModels);
}
