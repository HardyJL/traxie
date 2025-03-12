import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';
import 'package:traxie/widgets/traxie_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppDataBloc, AppDataBaseState>(
      listener: (context, state) {
        if (state is AppDataSelectingDateState) {
          context
              .read<NavigationCubit>()
              .updateState(NavigationScreens.flowTrackingScreen);
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 24),
            TraxieCalendar(),
          ],
        ),
      ),
    );
  }
}
