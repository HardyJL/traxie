import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';

class TraxieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TraxieAppBar({
    required this.title,
    super.key,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: actions ??
          [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {
                final bloc = context.read<AppDataBloc>();
                final state = bloc.state;
                await showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog.adaptive(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Journal Conut ${state.journalEntryModels.length} - Period Count ${state.periodModels.length}',
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: bloc.clearTestData,
                          child: const Text('Clear'),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Estimated Cycle Length: ${state.estimateAverage((e) => e.cycleLength)}',
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Estimated Period Length: ${state.estimateAverage((e) => e.periodLength)}',
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'durationUntilEstimatedPeriod: ${state.durationUntilEstimatedPeriod}',
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Estimated Period Start Date: ${state.estimatedPeriodStartDate}',
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Estimated Period End Date: ${state.estimatedNextPeriodEndDate}',
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
    );
  }

  @override
  Size get preferredSize =>
      const Size(double.infinity, kBottomNavigationBarHeight);
}
