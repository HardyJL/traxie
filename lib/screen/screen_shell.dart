import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';
import 'package:traxie/l10n/l10n.dart';
import 'package:traxie/screen/calendar/calendar_screen.dart';
import 'package:traxie/screen/flow_tracking_screen.dart';
import 'package:traxie/screen/history_screen.dart';
import 'package:traxie/screen/start_screen.dart';
import 'package:traxie/widgets/traxie_app_bar.dart';
import 'package:traxie/widgets/traxie_bottom_nav_bar.dart';

class ScreenShell extends StatelessWidget {
  const ScreenShell({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationCubit = context.read<NavigationCubit>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) async {
        switch (navigationCubit.state.currentScreen) {
          case NavigationScreens.mainScreen:
            Navigator.of(context).pop();
          case NavigationScreens.flowTrackingScreen:
            navigationCubit.updateState(NavigationScreens.calendarScreen);
          default:
            navigationCubit.updateState(NavigationScreens.mainScreen);
        }
      },
      child: Scaffold(
        appBar: TraxieAppBar(title: AppLocalizations.of(context).appBarTitle),
        drawer: SafeArea(
          child: NavigationDrawer(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  AppLocalizations.of(context).appBarTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Divider(),
              NavigationDrawerDestination(
                icon: Icon(Icons.arrow_upward_rounded),
                label: Text("Export"),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.arrow_downward_rounded),
                label: Text("Import"),
              ),
              NavigationDrawerDestination(icon: Icon(Icons.settings), label: Text("Settings")),
              Divider(),
              TextButton.icon(
                icon: Icon(Icons.copyright_rounded),
                label: Text("License"),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
            child: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                switch (state.currentScreen.index) {
                  case 0:
                    return const CalendarScreen();
                  case 1:
                    return const StartScreen();
                  case 2:
                    return const HistoryScreen();
                  case 3:
                    return const FlowTrackingScreen();
                }
                return Container();
              },
            ),
          ),
        ),
        bottomNavigationBar: const TraxieBottomNavBar(),
      ),
    );
  }
}
