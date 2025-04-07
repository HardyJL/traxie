import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState.initial());

  void ChangeMonth({bool forward = false}) {
    emit(
      state.copyWith(
        currentBaseDate: state.currentBaseDate.copyWith(
          month: state.currentBaseDate.month + (forward ? 1 : -1),
        ),
      ),
    );
  }
  void GoToToday() {
    emit(
      state.copyWith(
        currentBaseDate: GetIt.I.get<DateTime>(),
      ),
    );
  }
}
