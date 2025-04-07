import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/l10n/l10n.dart';
import 'package:traxie/theme_colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.height / 15;
    return BlocBuilder<AppDataBloc, AppDataBaseState>(
      builder: (context, state) {
        if (state is AppDataInitial) return const CircularProgressIndicator();
        return SizedBox(
          height:
              MediaQuery.of(context).size.height -
              kToolbarHeight -
              kBottomNavigationBarHeight -
              spacing,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: spacing,
              children: [
                Text(
                  AppLocalizations.of(context).nextPeriod(state.durationUntilEstimatedPeriod),
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                CycleProgressIndicator(state: state),
                Text(
                  AppLocalizations.of(context).daysLasting(state.estimatePeriodLength),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  state.estimatedPeriodStartDate != null
                      ? AppLocalizations.of(context).fromToDate(
                        state.estimatedPeriodStartDate!.asReadableString,
                        state.estimatedNextPeriodEndDate!.asReadableString,
                      )
                      : "",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CycleProgressIndicator extends StatelessWidget {
  const CycleProgressIndicator({super.key, required this.state});
  final AppDataBaseState state;
  final paddding = math.pi / 9;
  double customStepSize(idx, _) {
    return idx ==
            (state.estimateCycleLength - state.durationUntilEstimatedPeriod) %
                state.estimateCycleLength
        ? 48
        : 24;
  }
  double get angle =>
      (state.durationUntilEstimatedPeriod + 0.25) * (2 * math.pi) / state.estimateCycleLength;

  @override
  Widget build(BuildContext context) {
    return CircularStepProgressIndicator(
      height: MediaQuery.of(context).size.width - 120,
      width: MediaQuery.of(context).size.width - 120,
      padding: paddding,
      startingAngle: angle,
      totalSteps: state.estimateCycleLength,
      currentStep: state.estimatePeriodLength,
      customStepSize: customStepSize,
      selectedColor: TraxieTheme.mainRed,
      unselectedColor: Colors.grey,
    );
  }
}
