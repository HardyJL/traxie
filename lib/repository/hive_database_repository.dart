import 'package:hive/hive.dart';

class HiveDatabaseRepository<T extends HiveObject> {
  HiveDatabaseRepository({required this.currentBox});

  final Box<T> currentBox;

  Future<void> setTestData(List<T> testData) async {
    if (currentBox.isEmpty) {
      for (final data in testData) {
        await currentBox.add(data);
      }
    }
  }

  Future<void> addModel(T value) async {
    await currentBox.add(value);
  }

  List<T> getAllModels() {
    return currentBox.values.toList();
  }

  T getModelFromKey(String key) {
    return currentBox.get(key)!;
  }

  Future<void> deleteTrackingData(String key) async {
    await currentBox.delete(key);
  }

  Future<void> clearAllTrackingData() async {
    await currentBox.clear();
  }

  Future<void> close() async {
    await Hive.close();
  }
}
