import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/widgets/flow_intensity_checkbox.dart';

class FlowTrackingScreen extends StatelessWidget {
  const FlowTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataBaseState>(
      builder: (ctx, state) {
        final bloc = context.read<AppDataBloc>();
        if (state is AppDataSelectingDateState) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed:
                          () => bloc.add(
                            AppDataTrackingChangedPressedEvent(
                              trackingDate: state.currentModel.trackingDate.add(
                                const Duration(days: -1),
                              ),
                            ),
                          ),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      DateFormat.yMMMd().format(state.currentModel.trackingDate),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      onPressed:
                          () => bloc.add(
                            AppDataTrackingChangedPressedEvent(
                              trackingDate: state.currentModel.trackingDate.add(
                                const Duration(days: 1),
                              ),
                            ),
                          ),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                FlowIntensityCheckbox(
                  currentValue: state.currentModel.flowStrength,
                  onChanged:
                      (value) => bloc.add(
                        AppDataAddedOrChangedEvent(
                          entryModel: state.currentModel.copyWith(value: value),
                        ),
                      ),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
