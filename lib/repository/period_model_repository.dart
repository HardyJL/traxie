import 'package:traxie/extensions/date_extensions.dart';
import 'package:traxie/model/period_model.dart';
import 'package:traxie/repository/base_repository.dart';

class PeriodModelRepository extends BaseRepository<PeriodModel> {
  PeriodModelRepository({required super.hiveObjectBox});
  @override
  Future<void> addModel(PeriodModel model) {
    return super.hiveObjectBox.put(model.periodStartDate.asReadableString, model);
  }


  @override
  List<PeriodModel> getAllModels() {
    return hiveObjectBox.values.toList()..sort();
  }
}
