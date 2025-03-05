import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/screen/flow_tracking_screen.dart';
import 'package:traxie/widgets/traxie_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppDataBloc, AppDataBaseState>(
      listener: (ctx, state) {
        if (state is AppDataSelectingDateState) {}
        showDialog<void>(
          context: context,
          builder: (ctx) => const FlowTrackingSelectionDialog(),
        );
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
