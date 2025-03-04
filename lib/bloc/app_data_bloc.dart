import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/journal_entry_model_repository.dart';
import 'package:traxie/repository/period_model_repository.dart';

part 'app_data_event.dart';
part 'app_data_state.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataBaseState> {
  AppDataBloc()
      : super(
          const AppDataInitial(
            journalEntryModels: [],
            periodModels: [],
          ),
        ) {
    on<AppDataInitializedEvent>(_onAppDataInitializedEvent);
  }

  FutureOr<void> _onAppDataInitializedEvent(
    AppDataInitializedEvent event,
    Emitter<AppDataBaseState> emit,
  ) {
    final entryModelRepository = GetIt.I.get<JournalEntryModelRepository>();
    final periodModelRepository = GetIt.I.get<PeriodModelRepository>();
    if (state.journalEntryModels.isEmpty && state.periodModels.isEmpty) {
      emit(
        AppDataReadyState(
          journalEntryModels: entryModelRepository.getAllModels(),
          periodModels: periodModelRepository.getAllModels(),
        ),
      );
    }
  }

  Future<void> addEntryModel(JournalEntryModel model) async {
    return;
  }

  Future<void> clearTestData() async {
    final entryModelRepository = GetIt.I.get<JournalEntryModelRepository>();
    final periodModelRepository = GetIt.I.get<PeriodModelRepository>();
    await entryModelRepository.clearAllTrackingData();
    await periodModelRepository.clearAllTrackingData();
  }
}
