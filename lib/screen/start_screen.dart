import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/l10n/l10n.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataBaseState>(
      builder: (context, state) {
        if (state is AppDataInitial) return const CircularProgressIndicator();
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 24,
              children: [
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context).nextPeriod(state.durationUntilEstimatedPeriod),
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),
                SizedBox(
                  height: 220,
                  width: 220,
                  child: Transform.rotate(
                    angle:
                        state.durationUntilEstimatedPeriod /
                        state.estimateCycleLength *
                        360 *
                        (math.pi / 180),
                    child: CircularProgressIndicator(
                      color: const Color.fromARGB(255, 164, 14, 57),
                      strokeWidth: 20,
                      value: state.estimatePeriodLength / state.estimateCycleLength,
                      backgroundColor: const Color.fromARGB(255, 194, 236, 255),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  AppLocalizations.of(context).daysLasting(state.estimatePeriodLength),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).fromToDate(
                    state.estimatedPeriodStartDate.asReadableString,
                    state.estimatedNextPeriodEndDate.asReadableString,
                  ),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
