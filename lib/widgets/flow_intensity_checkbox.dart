import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';

class FlowIntensityCheckbox extends StatelessWidget {
  const FlowIntensityCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataBaseState>(
      builder: (context, state) {
        if (state is! AppDataSelectingDateState) {
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            CheckboxListTile(
              title: const Text('None'),
              value: state.currentModel.flowStrength == 0,
              onChanged: (value) => {},
            ),
            CheckboxListTile(
              title: const Text('Light'),
              value: state.currentModel.flowStrength == 1,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text('Middle'),
              value: state.currentModel.flowStrength == 2,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text('Heavy'),
              value: state.currentModel.flowStrength == 3,
              onChanged: (bool? value) {},
            ),
          ],
        );
      },
    );
  }
}
