import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';
import 'package:traxie/screen/calendar/cubit/calendar_cubit.dart';
import 'package:traxie/screen/calendar/traxie_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppDataBloc, AppDataBaseState>(
      listener: (context, state) {
        if (state is AppDataSelectingDateState) {
          context.read<NavigationCubit>().updateState(NavigationScreens.flowTrackingScreen);
        }
      },
      child: BlocProvider<CalendarCubit>(create: (ctx) => CalendarCubit(), child: TraxieCalendar()),
    );
  }
}
