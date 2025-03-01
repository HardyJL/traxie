part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState {
  const NavigationState(this.currentScreen);
  final NavigationScreens currentScreen;
}

final class NavigationChangedState extends NavigationState {
  const NavigationChangedState(super.currentScreen);
}
