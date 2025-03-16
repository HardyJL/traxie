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
            .where((e) => e.trackingDate.withoutTime == event.trackingDate.withoutTime)
            .firstOrNull ??
        JournalEntryModel(trackingDate: event.trackingDate, flowStrength: 0);
    print(journalModel);
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
    final JournalEntryModel eventModel = event.entryModel;
    final bool containsEventModel = state.journalEntryModels.containsDate(eventModel.trackingDate);

    if (eventModel.flowStrength == 0) {
      print('flowStrength == 0');
      if (containsEventModel) {
        entryModelRepository.deleteTrackingData(eventModel.key);
        state.journalEntryModels.remove(eventModel);
      }
    } else {
      print('flowStrength != 0');
      if (containsEventModel) {
        entryModelRepository.updateModel(eventModel);
        state.journalEntryModels[state.journalEntryModels.indexOf(eventModel)] = eventModel;
      } else {
        print('notContaining');
        entryModelRepository.addModel(eventModel);
        state.journalEntryModels.add(eventModel);
      }
    }
    // pinrt all values

    emit(
      AppDataSelectingDateState(
        journalEntryModels: state.journalEntryModels,
        periodModels: state.periodModels,
        currentModel: event.entryModel,
      ),
    );
  }
}
