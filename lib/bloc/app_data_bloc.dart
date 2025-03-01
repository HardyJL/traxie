import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/journal_entry_model_repository.dart';
import 'package:traxie/repository/period_model_repository.dart';

part 'app_data_event.dart';
part 'app_data_state.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataBaseState> {
  AppDataBloc() : super(const AppDataInitial([], [])) {
    on<AppDataInitializedEvent>(_onAppDataInitializedEvent);
  }

  FutureOr<void> _onAppDataInitializedEvent(
    AppDataInitializedEvent event,
    Emitter<AppDataBaseState> emit,
  ) {
    if (state.journalEntryModels.isEmpty && state.periodModels.isEmpty) {
      final journalEntryModels = GetIt.I.get<JournalEntryModelRepository>().getAllModels();
      final periodModels = GetIt.I.get<PeriodModelRepository>().getAllModels();
      emit(
        AppDataReadyState(
          journalEntryModels,
          periodModels,
        ),
      );
    }
  }
}
