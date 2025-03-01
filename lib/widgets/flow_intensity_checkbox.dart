// import 'package:flutter/material.dart';
// import 'package:period_tracker_hw/model/tracking_provider.dart';
// import 'package:provider/provider.dart';

// class FlowIntensityCheckbox extends StatelessWidget {
//   const FlowIntensityCheckbox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final flowTrackingProvider = Provider.of<TrackingProvider>(context);

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         CheckboxListTile(
//             title: const Text('None'),
//             value: flowTrackingProvider.currentModel.flowStrength == 0,
//             onChanged: (value) => removeIfExists(value, flowTrackingProvider)),
//         CheckboxListTile(
//           title: const Text('Light'),
//           value: flowTrackingProvider.currentModel.flowStrength == 1,
//           onChanged: (bool? value) {
//             if (value == true) {
//               // _onIntensityChanged(1);
//               updateCurrentValue(1, flowTrackingProvider);
//             }
//           },
//         ),
//         CheckboxListTile(
//           title: const Text('Middle'),
//           value: flowTrackingProvider.currentModel.flowStrength == 2,
//           onChanged: (bool? value) {
//             if (value == true) {
//               updateCurrentValue(2, flowTrackingProvider);
//             }
//           },
//         ),
//         CheckboxListTile(
//           title: const Text('Heavy'),
//           value: flowTrackingProvider.currentModel.flowStrength == 3,
//           onChanged: (bool? value) {
//             if (value == true) {
//               updateCurrentValue(3, flowTrackingProvider);
//             }
//           },
//         ),
//       ],
//     );
//   }

//   void removeIfExists(bool? value, TrackingProvider provider) {
//     provider.changeCurrentModelStrength(0);
//     provider.removeFlowTrackingModel(provider.currentModel);
//   }

//   void updateCurrentValue(int value, TrackingProvider provider) {
//     provider.addFlowTrackingModel(value);
//     provider.changeCurrentModelStrength(value);
//   }
// }
