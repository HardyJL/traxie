import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

enum NavigationScreens {
  calendarScreen,
  mainScreen,
  historyScreen,
  flowTrackingScreen,
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(
          const NavigationChangedState(
            NavigationScreens.mainScreen,
          ),
        );

  void updateState(NavigationScreens screen) {
    emit(NavigationChangedState(screen));
  }
}
