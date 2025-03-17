import 'package:bloc/bloc.dart';
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
}
