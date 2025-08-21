import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/journal_entry_model_repository.dart';
import 'package:traxie/repository/period_model_repository.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = const AppBlocObserver();

  if (kIsWeb) {
    Hive
      ..init(null)
      ..registerAdapter<JournalEntryModel>(JournalEntryModelAdapter())
      ..registerAdapter<PeriodModel>(PeriodModelAdapter());
  } else {
    final directory = await getApplicationDocumentsDirectory();
    Hive
      ..init(directory.path)
      ..registerAdapter<JournalEntryModel>(JournalEntryModelAdapter())
      ..registerAdapter<PeriodModel>(PeriodModelAdapter());
  }

  final journalEntryBox = await Hive.openBox<JournalEntryModel>('journalEntryBoxName');
  final periodBox = await Hive.openBox<PeriodModel>('periodModelBoxName');
  final journalEntryModelRepository = JournalEntryModelRepository(hiveObjectBox: journalEntryBox);
  final periodModelRepository = PeriodModelRepository(hiveObjectBox: periodBox);

  GetIt.I
    ..registerSingletonAsync<JournalEntryModelRepository>(() async => journalEntryModelRepository)
    ..registerSingletonAsync<PeriodModelRepository>(() async => periodModelRepository)
    ..registerSingleton<DateTime>(DateTime.now().noTime);

  runApp(await builder());
}

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
