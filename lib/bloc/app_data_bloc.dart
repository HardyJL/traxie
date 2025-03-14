import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:meta/meta.dart';
import 'package:traxie/extensions/period_list_extension.dart';
import 'package:traxie/extensions/tracking_list_extension.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/journal_entry_model_repository.dart';
import 'package:traxie/repository/period_model_repository.dart';

part 'app_data_event.dart';
part 'app_data_state.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataBaseState> {
  AppDataBloc({required this.periodModelRepository, required this.entryModelRepository})
    : super(const AppDataInitial(journalEntryModels: [], periodModels: [])) {
    on<AppDataInitializedEvent>(_onAppDataInitializedEvent);
    on<AppDataTrackingChangedPressedEvent>(_onAppDataTrackingChangedPressedEvent);
    on<AppDataAddedOrChangedEvent>(_onAppDataAddedOrChangedEvent);
  }
  final JournalEntryModelRepository entryModelRepository;
  final PeriodModelRepository periodModelRepository;

  FutureOr<void> _onAppDataInitializedEvent(
    AppDataInitializedEvent event,
    Emitter<AppDataBaseState> emit,
  ) {
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
    await entryModelRepository.clearAllTrackingData();
    await periodModelRepository.clearAllTrackingData();
  }

  FutureOr<void> _onAppDataTrackingChangedPressedEvent(
    AppDataTrackingChangedPressedEvent event,
    Emitter<AppDataBaseState> emit,
  ) {
    final journalModel =
        state.journalEntryModels
            .where((e) => e.trackingDate == event.trackingDate.withoutTime)
            .firstOrNull ??
        JournalEntryModel(trackingDate: event.trackingDate, flowStrength: 0);
    emit(
      AppDataSelectingDateState(
        journalEntryModels: state.journalEntryModels,
        periodModels: state.periodModels,
        currentModel: journalModel,
      ),
    );
  }

  FutureOr<void> _onAppDataAddedOrChangedEvent(
    AppDataAddedOrChangedEvent event,
    Emitter<AppDataBaseState> emit,
  ) {
    //TODO: add some kind of logic to load a periodModel at this point
    if (state.journalEntryModels.containsDate(event.entryModel.trackingDate)) {
      entryModelRepository.updateModel(event.entryModel);
    }
    entryModelRepository.addModel(event.entryModel);
    emit(
      AppDataReadyState(
        journalEntryModels: state.journalEntryModels..add(event.entryModel),
        periodModels: state.periodModels,
      ),
    );
  }
}
