import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppDataBloc>().state;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children:
              state.periodModels.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.periodLength.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              e.cycleLength.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 24,
                        width: MediaQuery.of(context).size.width / 33 * e.cycleLength,
                        child: LinearProgressIndicator(value: e.periodLength / e.cycleLength),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
