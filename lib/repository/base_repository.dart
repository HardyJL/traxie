import 'package:hive/hive.dart';

class BaseRepository<T extends HiveObject> {
  BaseRepository({required this.hiveObjectBox});

  final Box<T> hiveObjectBox;

  Future<void> addModel(T model) => throw UnimplementedError("Try calling the specific repository");

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
