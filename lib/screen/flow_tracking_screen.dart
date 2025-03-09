import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/widgets/flow_intensity_checkbox.dart';
import 'package:traxie/widgets/traxie_app_bar.dart';

class FlowTrackingScreen extends StatelessWidget {
  const FlowTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TraxieAppBar(title: 'Flow Tracking', actions: []),
      body: BlocBuilder<AppDataBloc, AppDataBaseState>(
        builder: (ctx, state) {
          if (state is! AppDataSelectingDateState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final bloc = context.read<AppDataBloc>();
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => bloc.add(
                        AppDataTrackingChangedPressedEvent(
                          trackingDate: state.currentModel.trackingDate.add(
                            const Duration(days: -1),
                          ),
                          isCurrentlyChanging: true,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      DateFormat.yMMMd()
                          .format(state.currentModel.trackingDate),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      onPressed: () => bloc.add(
                        AppDataTrackingChangedPressedEvent(
                          trackingDate: state.currentModel.trackingDate.add(
                            const Duration(days: 1),
                          ),
                          isCurrentlyChanging: true,
                          directionForward: true,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const FlowIntensityCheckbox(),
                Expanded(child: Container()),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Back to Calendar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
