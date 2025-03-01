// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:period_tracker_hw/model/tracking_provider.dart';
// import 'package:period_tracker_hw/repository/hive_database_repository.dart';
// import 'package:period_tracker_hw/repository/tracking_repository.dart';
// import 'package:period_tracker_hw/router/router.dart';
// import 'package:period_tracker_hw/theme_colors.dart';
// import 'package:provider/provider.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// void main() {
//   sqfliteFfiInit();
//   WidgetsFlutterBinding.ensureInitialized();
//   final GetIt getIt = GetIt.instance;
//   getIt.registerLazySingleton<TrackingRepository>(() => TrackingRepository());
//   getIt.registerLazySingleton<HiveDatabaseRepository>(() => HiveDatabaseRepository());

//   // Initialize any dependencies here
//   runApp(ChangeNotifierProvider<TrackingProvider>(
//     create: (context) => TrackingProvider(),
//     // lazy: false,
//     child: const Traxie(),
//   ));
// }

// class Traxie extends StatelessWidget {
//   const Traxie({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<TrackingProvider>(context, listen: false).getAllFlowTrackingModels();
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Traxie - A tracking app',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: PaddyTheme.mainBlue,
//           primary: PaddyTheme.mainRed,
//         ),
//         useMaterial3: true,
//       ),
//       routerConfig: router,
//     );
//   }
// }
