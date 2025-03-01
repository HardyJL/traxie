// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:period_tracker_hw/model/tracking_provider.dart';
// import 'package:period_tracker_hw/widgets/flow_intensity_checkbox.dart';
// import 'package:period_tracker_hw/widgets/paddy_app_bar.dart';
// import 'package:provider/provider.dart';

// class FlowTrackingScreen extends StatelessWidget {
//   const FlowTrackingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TrackingProvider>(context);
//     return Scaffold(
//         appBar: PaddyAppBar(
//           title: "Flow Tracking",
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Center(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(height: 32),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 IconButton(
//                   onPressed: () {
//                     context.replace('/flow-tracking',
//                         extra: provider.currentModel.trackingDate.subtract(Duration(days: 1)));
//                   },
//                   icon: Icon(Icons.arrow_back),
//                 ),
//                 Text(
//                   DateFormat.yMMMd().format(provider.currentModel.trackingDate),
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       context.replace(
//                         '/flow-tracking',
//                         extra: provider.currentModel.trackingDate.add(
//                           Duration(days: 1),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.arrow_forward))
//               ]),
//               SizedBox(height: 32),
//               FlowIntensityCheckbox(),
//             ],
//           )),
//         ));
//   }
// }
