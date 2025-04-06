import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/journal_entry_model.dart';

extension TrackingListExtension on List<JournalEntryModel> {
  bool containsDate(DateTime date) {
    return indexWhere((e) => e.trackingDate.noTime.isAtSameMomentAs(date.noTime)) != -1;
  }

  String flatten() {
    return this.map((e) => e.toString()).join('\n');
  }

  DateTime? get lastPeriodStartDate {
    final _reversedList = this.reversed.toList();
    for (int i = 0; i < _reversedList.length - 1; i++) {
      final _currentTrackingModel = _reversedList[i];
      if (!_currentTrackingModel.trackingDate.isDayAfter(_reversedList[i + 1].trackingDate)) {
        return _currentTrackingModel.trackingDate;
      }
    }
    return null;
  }
}
