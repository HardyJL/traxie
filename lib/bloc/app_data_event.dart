part of 'app_data_bloc.dart';

@immutable
sealed class AppDataEvent {}

class AppDataInitializedEvent extends AppDataEvent {}

class AppDataChangedEvent extends AppDataEvent {}

class AppDataTrackingChangedPressedEvent extends AppDataEvent {
  AppDataTrackingChangedPressedEvent({
    required this.trackingDate,
    this.isCurrentlyChanging = false,
    this.directionForward = false,
  });

  final DateTime trackingDate;

  final bool directionForward;
  final bool isCurrentlyChanging;
}
