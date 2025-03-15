import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';

class FlowIntensityCheckbox extends StatefulWidget {
  const FlowIntensityCheckbox({super.key});

  @override
  State<FlowIntensityCheckbox> createState() => _FlowIntensityCheckboxState();
}

class _FlowIntensityCheckboxState extends State<FlowIntensityCheckbox> {
  int currentValue = 0;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('None'),
          value: currentValue == 0,
          onChanged: (_) {
            addToDataBloc(bloc, 0);
            setState(() {
              currentValue = 0;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Light'),
          value: currentValue == 1,
          onChanged: (_) {
            addToDataBloc(bloc, 1);
            setState(() {
              currentValue = 1;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Middle'),
          value: currentValue == 2,
          onChanged: (_) {
            addToDataBloc(bloc, 2);
            setState(() {
              currentValue = 2;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Heavy'),
          value: currentValue == 3,
          onChanged: (_) {
            addToDataBloc(bloc, 3);
            setState(() {
              currentValue = 3;
            });
          },
        ),
      ],
    );
  }

  void addToDataBloc(AppDataBloc bloc, int value) {
    bloc.add(
      AppDataAddedOrChangedEvent(
        entryModel: (bloc.state as AppDataSelectingDateState).currentModel.copyWith(value: value),
      ),
    );
  }
}
