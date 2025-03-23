import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/journal_entry_model.dart';

extension TrackingListExtension on List<JournalEntryModel> {
  bool containsDate(DateTime date) {
    return indexWhere((e) => e.trackingDate.noTime.isAtSameMomentAs(date.noTime)) != -1;
  }

  String flatten() {
    return this.map((e) => e.toString()).join('\n');
  }
}
