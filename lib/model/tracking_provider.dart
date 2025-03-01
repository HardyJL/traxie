// // import 'package:get_it/get_it.dart';
// // import 'package:period_tracker_hw/repository/tracking_repository.dart';
// import 'package:calendar_view/calendar_view.dart';
// import 'package:flutter/material.dart';
// import 'package:traxie/model/period_model.dart';
// import 'flow_tracking_model.dart';

// class TrackingProvider with ChangeNotifier {
//   // all available tracking models - are gotten from the database
//   List<FlowTrackingModel> _flowTrackingModels = [];
//   // current tracking model - is used to add a new tracking model
//   FlowTrackingModel _currentModel = FlowTrackingModel(trackingDate: DateTime.now(), flowStrength: 0);
//   // current route - is used to navigate between the pages
//   int _currentRoute = 1;
//   // estimate cycle length - is used to calculate the next period date
//   int _estimateCycleLength = 28;
//   // estimate period length - is used to calculate the next period date
//   int _estimatePeriodLength = 5;

//   final List<PeriodModel> _pastPeriods = [];

//   // Getter methods

//   int get currentRoute => _currentRoute;

//   FlowTrackingModel get currentModel => _currentModel;
//   List<FlowTrackingModel> get flowTrackingModels => _flowTrackingModels;

//   int get estimateCycleLength => _estimateCycleLength;
//   int get estimatePeriodLength => _estimatePeriodLength;
//   int get durationUntilEstimatedPeriod => estimatedPeriodStartDate.difference(DateTime.now().withoutTime).inDays;
//   List<PeriodModel> get pastPeriods => _pastPeriods;

//   DateTime get estimatedPeriodEndDate => estimatedPeriodStartDate.add(Duration(days: _estimatePeriodLength));
//   DateTime get estimatedPeriodStartDate {
//     return _pastPeriods.lastOrNull?.periodStartDate.add(Duration(days: _estimateCycleLength)) ?? DateTime(1900, 1, 1);
//   }

//   /// changes the current route of the application
//   /// used for navigation
//   void changeCurrentRoute(int route) => _currentRoute = route;

//   /// Function to add flowtrackingmodel to the model list
//   /// Adds the the current model
//   Future<void> addFlowTrackingModel(int value) async {
//     if (_flowTrackingModels.containsDate(currentModel.trackingDate)) {
//       _flowTrackingModels[_flowTrackingModels.indexOf(currentModel)].flowStrength = value;
//     } else {
//       _flowTrackingModels.add(currentModel);
//     }
//     notifyListeners();
//   }

//   /// Baisc function to get flow tracking models.
//   /// This polls the SQLite database from the Tracking repository
//   Future<void> getAllFlowTrackingModels() async {
//     _flowTrackingModels = testData;
//     final repository = GetIt.I.get<HiveDatabaseRepository>();
//     await repository.init();
//     await repository.addTrackingData('Model', testData.first);
//     repository.getAllModels();
//     await loadPastPeriods();
//     await calculateAveragePeriodTimes();
//     notifyListeners();
//   }

//   /// Function to remove flowtrackingmodel from the list
//   Future<void> removeFlowTrackingModel(FlowTrackingModel model) async {
//     final didRemove = _flowTrackingModels.remove(model);
//     if (didRemove) notifyListeners();
//   }

//   /// used to change the current model based on the input given
//   /// this is used when navigating the model update pages
//   void changeCurrentModel(FlowTrackingModel model) => _currentModel = model;

//   /// Changes the period strength for the current model
//   void changeCurrentModelStrength(int strength) {
//     _currentModel.flowStrength = strength;
//     notifyListeners();
//   }

//   /// Function to get all of the period events for a day.
//   /// This is used for the calendar to get events based on when the periods where entered.
//   List<String> getPeriodEvents(DateTime day) {
//     List<String> events = [];
//     for (var model in _flowTrackingModels) {
//       if (model.trackingDate.year == day.year &&
//           model.trackingDate.month == day.month &&
//           model.trackingDate.day == day.day) {
//         events.add("Flow strength: ${model.flowStrength}");
//       }
//     }
//     return events;
//   }

//   /// Init function for the current model
//   void initializeCurrentModel(DateTime date) => _currentModel = FlowTrackingModel(trackingDate: date, flowStrength: 0);

//   /// Converts all entrys in the _flowTracking models into a PeriodModel
//   /// This is used in the history screen to show the bars
//   Future<void> loadPastPeriods() async {
//     if (_pastPeriods.isNotEmpty) {
//       return;
//     }

//     late int cycleLength;
//     late int periodLength;
//     late DateTime periodStartDate;
//     late DateTime periodEndDate;
//     bool periodStarted = false;

//     for (int i = 0; i <= flowTrackingModels.length - 1; i++) {
//       final periodEntry = flowTrackingModels[i];

//       // If the difference between the next entry and the current one is bigger than 1 day the period has ended
//       if (i == flowTrackingModels.length - 1) {
//         periodEndDate = periodEntry.trackingDate;
//         cycleLength = _estimateCycleLength;
//         periodLength = periodEndDate.difference(periodStartDate).inDays + 1;
//         _pastPeriods.add(
//           PeriodModel(
//             cycleLength: cycleLength,
//             periodLength: periodLength,
//             periodStartDate: periodStartDate,
//             periodEndDate: periodEndDate,
//           ),
//         );
//         break;
//       }

//       final nextEntry = flowTrackingModels[i + 1];
//       if (nextEntry.trackingDate.difference(periodEntry.trackingDate).inDays == 1) {
//         if (periodStarted) {
//           continue;
//         }
//         periodStartDate = periodEntry.trackingDate;
//         periodStarted = true;
//       } else {
//         periodEndDate = periodEntry.trackingDate;
//         periodLength = periodEndDate.difference(periodStartDate).inDays + 1;
//         cycleLength = nextEntry.trackingDate.difference(periodStartDate).inDays + 1;

//         _pastPeriods.add(
//           PeriodModel(
//             cycleLength: cycleLength,
//             periodLength: periodLength,
//             periodStartDate: periodStartDate,
//             periodEndDate: periodEndDate,
//           ),
//         );
//         periodStarted = false;
//       }
//     }
//   }

//   // Function to change the estimates of the period length and cycle length
//   void changeEstimates(int cycleLength, int periodLength) {
//     _estimateCycleLength = cycleLength;
//     _estimatePeriodLength = periodLength;
//     notifyListeners();
//   }

//   Future<void> calculateAveragePeriodTimes() async {
//     if (_pastPeriods.isEmpty) return;
//     final cleanedList = _pastPeriods.ignoreLast();

//     _pastPeriods.ignoreLast().forEach((e) => print(e));

//     _estimateCycleLength = (cleanedList.map((e) => e.cycleLength).reduce((a, b) => a + b) / cleanedList.length).round();
//     _estimatePeriodLength =
//         (cleanedList.map((e) => e.periodLength).reduce((a, b) => a + b) / cleanedList.length).round();
//   }
// }
