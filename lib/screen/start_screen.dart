import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:traxie/repository/hive_database_repository.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 24,
            children: [
              const SizedBox(height: 24),
              Text(
                'Your next period is estimated to be in ${1} days',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              SizedBox(
                height: 220,
                width: 220,
                child: Transform.rotate(
                  angle: 0,
                  // TODO fix this
                  // angle: provider.durationUntilEstimatedPeriod /
                  //     provider.estimateCycleLength *
                  //     360 *
                  //     (math.pi / 180),
                  child: const CircularProgressIndicator(
                    value: 1 / 2,
                    color: Color.fromARGB(255, 164, 14, 57),
                    strokeWidth: 20,
                    // value: provider.estimatePeriodLength /
                    //     provider.estimateCycleLength,
                    backgroundColor: Color.fromARGB(255, 194, 236, 255),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'And should last about ${1} days',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                'From ${DateFormat('dd.MM.yyyy').format(DateTime.now())} to ${DateFormat('dd.MM.yyyy').format(DateTime.now())}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () =>
                      GetIt.I.get<HiveDatabaseRepository>().getAllModels(),
                  child: const Text('Test Data'),),
            ],
          ),
        ),
      ),
    );
  }
}
