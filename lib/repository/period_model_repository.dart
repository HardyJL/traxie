import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/hive_database_repository.dart';

class PeriodModelRepository extends HiveDatabaseRepository<PeriodModel> {
  PeriodModelRepository({required super.hiveObjectBox});
  @override
  Future<void> addModel(PeriodModel model) {
    return super.hiveObjectBox.put(model.periodStartDate.toReadableString(), model);
  }

  @override
  Future<void> setTestData(List<PeriodModel> testData) async {
    if (hiveObjectBox.isEmpty) {
      for (final data in testData) {
        await addModel(data);
      }
    }
  }

  @override
  List<PeriodModel> getAllModels() {
    return hiveObjectBox.values.toList()
      ..sort((a, b) => a.periodStartDate.compareTo(b.periodStartDate));
  }
}
