// import 'package:flutter/material.dart';
// import 'package:period_tracker_hw/model/tracking_provider.dart';
// import 'package:period_tracker_hw/widgets/paddy_app_bar.dart';
// import 'package:provider/provider.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TrackingProvider>(context, listen: false);
//     return Scaffold(
//       appBar: PaddyAppBar(
//         title: "Settings",
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Text("Estimated estimateCycleLength length: (${provider.estimateCycleLength.toString()})"),
//               Text("Estimated estimatePeriodLength length: (${provider.estimatePeriodLength.toString()})"),
//               Text(
//                   "Estimated durationUntilEstimatedPeriod length: (${provider.durationUntilEstimatedPeriod.toString()})"),
//               Text("Estimated estimatedPeriodStartDate length: (${provider.estimatedPeriodStartDate.toString()})"),
//               Text("Estimated estimatedPeriodEndDate length: (${provider.estimatedPeriodEndDate.toString()})"),
//               Text("Estimated last start date: (${provider.pastPeriods.lastOrNull?.periodStartDate.toString()})"),
//               // Text("Estimated cycle length: (${provider.estimateCycleLength.toString()})"),
//             ]
//                 .map((e) => Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: e,
//                     ))
//                 .toList(),
//             // child: Text(
//             //   Provider.of<TrackingProvider>(context).flowTrackingModels.join("\n \n"),
//             // ),
//           ),
//         ),
//       ),
//     );
//   }
// }
