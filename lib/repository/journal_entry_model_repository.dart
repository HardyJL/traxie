import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/repository/hive_database_repository.dart';

class JournalEntryModelRepository extends HiveDatabaseRepository<JournalEntryModel> {
  JournalEntryModelRepository({required super.hiveObjectBox});

  @override
  Future<void> addModel(JournalEntryModel model) {
    return hiveObjectBox.put(model.trackingDate.asReadableString, model);
  }

  @override
  Future<void> setTestData(List<JournalEntryModel> testData) async {
    if (hiveObjectBox.isEmpty) {
      for (final data in testData) {
        await addModel(data);
      }
    }
  }

  @override
  List<JournalEntryModel> getAllModels() {
    return hiveObjectBox.values.toList()..sort((a, b) => a.trackingDate.compareTo(b.trackingDate));
  }
}
