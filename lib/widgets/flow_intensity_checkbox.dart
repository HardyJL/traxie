import 'package:flutter/material.dart';
import 'package:traxie/theme_colors.dart';

class FlowIntensityCheckbox extends StatelessWidget {
  final int currentValue;
  final Function(int) onChanged;

  const FlowIntensityCheckbox({super.key, required this.currentValue, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('None'),
          value: currentValue == 0,
          activeColor: TraxieTheme.mainRed.withValues(alpha: 0.5),
          onChanged: (_) => onChanged(0),
        ),
        CheckboxListTile(
          title: const Text('Light'),
          value: currentValue == 1,
          onChanged: (_) => onChanged(1),
        ),
        CheckboxListTile(
          title: const Text('Middle'),
          value: currentValue == 2,
          onChanged: (_) => onChanged(2),
        ),
        CheckboxListTile(
          title: const Text('Heavy'),
          value: currentValue == 3,
          onChanged: (_) => onChanged(3),
        ),
      ],
    );
  }

  // void addToDataBloc(AppDataBloc bloc, int value) {
  //   bloc.add(
  //     AppDataAddedOrChangedEvent(
  //       entryModel: (bloc.state as AppDataSelectingDateState).currentModel.copyWith(value: value),
  //     ),
  //   );
  // }
}
