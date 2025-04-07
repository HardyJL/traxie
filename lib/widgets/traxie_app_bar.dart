import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/cubit/navigation_cubit.dart';
import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/extensions/tracking_list_extension.dart';
import 'package:traxie/repository/journal_entry_model_repository.dart';
import 'package:traxie/repository/period_model_repository.dart';

class TraxieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TraxieAppBar({required this.title, super.key, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return AppBar(
          title: Text(title),
          leading:
              state.currentScreen == NavigationScreens.flowTrackingScreen
                  ? IconButton(
                    onPressed:
                        () => context.read<NavigationCubit>().updateState(
                          NavigationScreens.calendarScreen,
                        ),
                    icon: Icon(Icons.arrow_back),
                  )
                  : null,
          centerTitle: true,
          actions:
              actions ??
              [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () async {
                    final bloc = context.read<AppDataBloc>();
                    final state = bloc.state;
                    final repository = GetIt.I.get<JournalEntryModelRepository>();
                    final periodRepository = GetIt.I.get<PeriodModelRepository>();
                    await showDialog<void>(
                      context: context,
                      builder:
                          (_) => AlertDialog.adaptive(
                            content: SingleChildScrollView(
                              child: Column(
                                spacing: 12,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Journal Conut ${state.journalEntryModels.length} - Period Count ${state.periodModels.length}',
                                  ),
                                  ElevatedButton(
                                    onPressed: bloc.clearTestData,
                                    child: const Text('Clear'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                    final date = GetIt.I.get<DateTime>();
                                    GetIt.I.registerSingleton<DateTime>(date.add(Duration(days: 1)));
                                    },
                                    child: const Text('Next Date'),
                                  ),
                                  Text(GetIt.I.get<DateTime>().asReadableString), 
                                  Text(
                                    'Estimated Cycle Length: ${state.estimateAverage((e) => e.cycleLength)}',
                                  ),
                                  Text(
                                    'Estimated Period Length: ${state.estimateAverage((e) => e.periodLength)}',
                                  ),
                                  Text(
                                    'durationUntilEstimatedPeriod: ${state.durationUntilEstimatedPeriod}',
                                  ),
                                  Text(
                                    'Estimated Period Start Date: ${state.estimatedPeriodStartDate}',
                                  ),
                                  Text(
                                    'Estimated Period End Date: ${state.estimatedNextPeriodEndDate}',
                                  ),
                                  // Text(repository.getAllModels().flatten()),
                                  // Text(periodRepository.getAllModels().map((e) => e.toString()).join('\n')),
                                ],
                              ),
                            ),
                          ),
                    );
                  },
                ),
              ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kBottomNavigationBarHeight);
}
