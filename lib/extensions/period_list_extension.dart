import 'package:traxie/model/period_model.dart';

extension PeriodListExtension on List<PeriodModel> {
  List<PeriodModel> ignoreLast() {
    return sublist(0, length - 1);
  }
}
