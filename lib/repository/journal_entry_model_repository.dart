import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/repository/hive_database_repository.dart';

class JournalEntryModelRepository extends HiveDatabaseRepository<JournalEntryModel> {
  JournalEntryModelRepository({required super.hiveObjectBox});
}
