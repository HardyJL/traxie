import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/hive_database_repository.dart';
import 'package:traxie/repository/journal_entry_model_repository.dart';
import 'package:traxie/repository/period_model_repository.dart';
import 'package:traxie/repository/test_data.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = const AppBlocObserver();

  Hive
    ..registerAdapter<JournalEntryModel>(JournalEntryModelAdapter())
    ..registerAdapter<PeriodModel>(PeriodModelAdapter());


  GetIt.I
    ..registerSingletonAsync(
      () => registerRepository<JournalEntryModel>(
        JournalEntryModelRepository(boxName: 'journaEntry'),
        journalEntryTestData,
      ),
    )
    ..registerSingletonAsync(
      () => registerRepository(PeriodModelRepository(boxName: 'periods'), []),
    );
  // Add cross-flavor configuration here

  runApp(await builder());
}

Future<HiveDatabaseRepository<T>> registerRepository<T>(
  HiveDatabaseRepository<T> repository,
  List<T> testData,
) async {
  await repository.init();
  await repository.setTestData(testData);
  return repository;
}
