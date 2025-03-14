import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';

class TraxieBottomNavBar extends StatelessWidget {
  const TraxieBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final navCubit = context.read<NavigationCubit>();
        return NavigationBar(
          selectedIndex: context.read<NavigationCubit>().state.currentScreen.index % 3,
          onDestinationSelected: (value) {
            switch (value) {
              case 0:
                navCubit.updateState(NavigationScreens.calendarScreen);
              case 1:
                navCubit.updateState(NavigationScreens.mainScreen);
              case 2:
                navCubit.updateState(NavigationScreens.historyScreen);
            }
          },
          destinations: const [
            NavigationDestination(label: 'Calendar', icon: Icon(Icons.crop_din_rounded)),
            NavigationDestination(label: 'Overview', icon: Icon(Icons.circle_outlined)),
            NavigationDestination(label: 'History', icon: Icon(Icons.line_style_rounded)),
          ],
        );
      },
    );
  }
}
