import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/extensions/date_extensions.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppDataBloc>().state;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
            state.periodModels.reversed.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      "${e.periodStartDate.asReadableString} - ${e.periodEndDate.asReadableString}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Period lasted ${e.periodLength} days",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        SizedBox(
                          height: 24,
                          width: MediaQuery.of(context).size.width / 38 * e.cycleLength,
                          child: LinearProgressIndicator(value: e.periodLength / e.cycleLength),
                        ),
                        Text(
                          e.cycleLength.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
