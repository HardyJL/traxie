import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';
import 'package:traxie/l10n/l10n.dart';
import 'package:traxie/repository/journal_entry_model_repository.dart';
import 'package:traxie/repository/period_model_repository.dart';
import 'package:traxie/screen/screen_shell.dart';
import 'package:traxie/theme_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        BlocProvider<AppDataBloc>(
          create:
              (context) => AppDataBloc(
                entryModelRepository: GetIt.I.get<JournalEntryModelRepository>(),
                periodModelRepository: GetIt.I.get<PeriodModelRepository>(),
              )..add(AppDataInitializedEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Traxie - A tracking app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: TraxieTheme.mainBlue,
            primary: TraxieTheme.mainRed,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const ScreenShell(),
      ),
    );
  }
}
