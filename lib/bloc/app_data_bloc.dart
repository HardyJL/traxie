import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:traxie/extensions/date_extensions.dart';
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
            .where((e) => e.trackingDate.noTime == event.trackingDate.noTime)
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
    final List<JournalEntryModel> _updatedJournalEntryList = state.journalEntryModels;
    final List<PeriodModel> _updatedPeriodList = state.periodModels;
    final JournalEntryModel _eventModel = event.entryModel;
    final bool _containsEventModel = _updatedJournalEntryList.containsDate(
      _eventModel.trackingDate,
    );
    if (_eventModel.flowStrength == 0) {
      if (_containsEventModel) {
        entryModelRepository.deleteTrackingData(_eventModel.trackingDate.asReadableString);
      }
    } else {
      if (_containsEventModel) {
        entryModelRepository.updateModel(_eventModel);
        _updatedJournalEntryList[_updatedJournalEntryList.indexOf(_eventModel)] = _eventModel;
      } else {
        entryModelRepository.addModel(_eventModel);
        if (!_eventModel.trackingDate.isDayAfter(_updatedJournalEntryList.last.trackingDate)) {
          final _newPeriodModel = createNextPeriod(_eventModel.trackingDate);
          if (_newPeriodModel != null) {
            _updatedPeriodList.add(_newPeriodModel);
          }
        }
        _updatedJournalEntryList.add(_eventModel);
      }
    }
    emit(
      AppDataSelectingDateState(
        journalEntryModels: _updatedJournalEntryList,
        periodModels: _updatedPeriodList,
        currentModel: _eventModel,
      ),
    );
  }

  DateTime? get _getPeriodStartDate {
    final _reversedList = state.journalEntryModels.reversed.toList();
    // Traverse the list of reversed TrackingModels and find the first time that there
    // is a difference in the dates. Onces we have that  we can use that as the  start date
    // since this executes before we re add the models this should work
    for (int i = 0; i < _reversedList.length - 1; i++) {
      final _currentTrackingModel = _reversedList[i];
      if (!_currentTrackingModel.trackingDate.isDayAfter(_reversedList[i + 1].trackingDate)) {
        return _currentTrackingModel.trackingDate;
      }
    }
    return null;
  }

  PeriodModel? createNextPeriod(DateTime newPeriodStart) {
    if (state.journalEntryModels.isEmpty || state.journalEntryModels.length <= 1) return null;

    final DateTime? _periodStartDate = _getPeriodStartDate;
    final DateTime _periodEndDate = state.journalEntryModels.last.trackingDate;

    if (_periodStartDate == null) return null;

    return PeriodModel(
      cycleLength: newPeriodStart.difference(_periodStartDate).inDays,
      periodLength: _periodEndDate.difference(_periodStartDate).inDays,
      periodStartDate: _periodStartDate,
      periodEndDate: _periodEndDate,
    );
  }
}
