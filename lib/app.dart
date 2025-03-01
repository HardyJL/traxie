import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';
import 'package:traxie/l10n/l10n.dart';
import 'package:traxie/screen/screen_shell.dart';
import 'package:traxie/theme_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
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
