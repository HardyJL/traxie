import 'package:hive/hive.dart';

class HiveDatabaseRepository<T extends HiveObject> {
  HiveDatabaseRepository({required this.hiveObjectBox});

  final Box<T> hiveObjectBox;

  Future<void> setTestData(List<T> testData) async {
    if (hiveObjectBox.isEmpty) {
      for (final data in testData) {
        await hiveObjectBox.add(data);
      }
    }
  }

  Future<void> addModel(T model) async {
    await hiveObjectBox.add(model);
  }

  Future<void> updateModel(T model) async {
    await hiveObjectBox.put(model.key, model);
  }

  List<T> getAllModels() {
    return hiveObjectBox.values.toList();
  }

  T getModelFromKey(String key) {
    return hiveObjectBox.get(key)!;
  }

  Future<void> deleteTrackingData(String key) async {
    await hiveObjectBox.delete(key);
  }

  Future<void> clearAllTrackingData() async {
    await hiveObjectBox.clear();
  }

  Future<void> close() async {
    await Hive.close();
  }
}
