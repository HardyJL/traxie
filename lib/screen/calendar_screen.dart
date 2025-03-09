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
        if (state is AppDataSelectingDateState) {
          state.isCurrentlyChanging
              ? Navigator.of(ctx).pushReplacement(
                  PageRouteBuilder<void>(
                    pageBuilder: (_, __, ___) => const FlowTrackingScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final begin = Offset(state.directionForward ? 1 : -1, 0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                )
              : Navigator.of(ctx).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const FlowTrackingScreen(),
                  ),
                );
        }
        // navigate to flowTrackingScreen
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
