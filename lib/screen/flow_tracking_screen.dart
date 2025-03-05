import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:traxie/bloc/app_data_bloc.dart';
import 'package:traxie/widgets/flow_intensity_checkbox.dart';

class FlowTrackingSelectionDialog extends StatelessWidget {
  const FlowTrackingSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataBaseState>(
      builder: (ctx, state) {
        if (state is! AppDataSelectingDateState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        final size = MediaQuery.of(ctx).size;
        return Dialog(
          child: Card(
            child: SizedBox(
              width: size.width - 8,
              height: size.height - 48,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back),
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(state.currentModel.trackingDate),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const FlowIntensityCheckbox(),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
