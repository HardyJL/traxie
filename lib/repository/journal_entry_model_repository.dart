import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/repository/base_repository.dart';

class JournalEntryModelRepository extends BaseRepository<JournalEntryModel> {
  JournalEntryModelRepository({required super.hiveObjectBox});

  @override
  Future<void> addModel(JournalEntryModel model) {
    return hiveObjectBox.put(model.trackingDate.asReadableString, model);
  }

  @override
  List<JournalEntryModel> getAllModels() {
    return hiveObjectBox.values.toList()..sort((a, b) => a.trackingDate.compareTo(b.trackingDate));
  }
}
