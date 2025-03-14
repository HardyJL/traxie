import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/hive_database_repository.dart';

class PeriodModelRepository extends HiveDatabaseRepository<PeriodModel> {
  PeriodModelRepository({required super.hiveObjectBox});
}
