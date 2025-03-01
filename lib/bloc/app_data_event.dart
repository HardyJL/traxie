part of 'app_data_bloc.dart';

@immutable
sealed class AppDataEvent {}

class AppDataInitializedEvent extends AppDataEvent {}

class AppDataChangedEvent extends AppDataEvent {}
