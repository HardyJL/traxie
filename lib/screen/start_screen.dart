import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/l10n/arb/app_localizations.dart';
import 'package:traxie/theme_colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.height / 18;
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
                  state.durationUntilEstimatedPeriod != null
                      ? AppLocalizations.of(context).nextPeriod(state.durationUntilEstimatedPeriod!)
                      : AppLocalizations.of(context).nothingAdded,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                CycleProgressIndicator(state: state),
                Text(
                  state.estimatePeriodLength != null
                      ? AppLocalizations.of(context).daysLasting(state.estimatePeriodLength!)
                      : AppLocalizations.of(context).onceAddedShow,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
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
    if (state.durationUntilEstimatedPeriod == null) return 20;
    return idx ==
            (state.estimateCycleLength! - state.durationUntilEstimatedPeriod!) %
                state.estimateCycleLength!
        ? 48
        : 24;
  }

  double get angle =>
      state.durationUntilEstimatedPeriod != null
          ? (state.durationUntilEstimatedPeriod! + 0.25) *
              (2 * math.pi) /
              state.estimateCycleLength!
          : 0.05;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: () {
            showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2300),
              initialEntryMode: DatePickerEntryMode.input,
              locale: Localizations.localeOf(context),

              helpText: "Select a period start and end date. You can also enter the approximate dates"
            );
          },
          icon: Icon(Icons.add),
          color: TraxieTheme.mainRed,
          iconSize: 48,
        ),

        CircularStepProgressIndicator(
          height: MediaQuery.of(context).size.width - 120,
          width: MediaQuery.of(context).size.width - 120,
          padding: paddding,
          startingAngle: angle,
          totalSteps: state.estimateCycleLength ?? 28,
          currentStep: state.estimatePeriodLength ?? 1,
          customStepSize: customStepSize,
          selectedColor: TraxieTheme.mainRed,
          unselectedColor: Colors.grey,
        ),
      ],
    );
  }
}
