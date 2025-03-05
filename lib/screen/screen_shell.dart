import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';
import 'package:traxie/screen/calendar_screen.dart';
import 'package:traxie/screen/history_screen.dart';
import 'package:traxie/screen/start_screen.dart';
import 'package:traxie/widgets/traxie_app_bar.dart';
import 'package:traxie/widgets/traxie_bottom_nav_bar.dart';

class ScreenShell extends StatelessWidget {
  const ScreenShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TraxieAppBar(
        title: 'Traxie',
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            switch (state.currentScreen.index) {
              case 0:
                return const CalendarScreen();
              case 1:
                return const StartScreen();
              case 2:
                return const HistoryScreen();
            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: const TraxieBottomNavBar(),
    );
  }
}
