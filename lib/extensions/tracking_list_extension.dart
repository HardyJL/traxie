
import 'package:calendar_view/calendar_view.dart';
import 'package:traxie/model/journal_entry_model.dart';

extension TrackingListExtension on List<JournalEntryModel> {
  bool containsDate(DateTime date) {
    return indexWhere((e) => e.trackingDate.withoutTime.isAtSameMomentAs(date.withoutTime)) != -1;
  }
}
