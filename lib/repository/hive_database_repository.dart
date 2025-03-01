import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveDatabaseRepository<HiveObject> {
  HiveDatabaseRepository({required this.boxName});

  final String boxName;

  Future<void> init() async {
    final applicationDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(applicationDocumentDirectory.path);
    // Hive.registerAdapter<FlowTrackingModel>();
    await Hive.openBox<HiveObject>(boxName);
  }

  Future<void> setTestData(List<HiveObject> testData) async {
    final currentBox = Hive.box<HiveObject>(boxName);
    if (testData.every((e) => currentBox.values.contains(e)) == true) {}
    for (final data in testData) {
      await currentBox.add(data);
    }
  }

  Future<void> addTrackingData(String key, HiveObject value) async {
    final box = Hive.box<HiveObject>(boxName);
    await box.put(key, value);
  }

  List<HiveObject> getAllModels() {
    final box = Hive.box<HiveObject>(boxName);
    print(box.values.map((e) => e.toString()));
    print(box.keys.map((e) => e.toString()));
    return [];
  }

  HiveObject getTrackingData(String key) {
    final box = Hive.box<HiveObject>(boxName);
    return box.get(key)!;
  }

  Future<void> deleteTrackingData(String key) async {
    final box = Hive.box<HiveObject>(boxName);
    await box.delete(key);
  }

  Future<void> clearAllTrackingData() async {
    final box = Hive.box<HiveObject>(boxName);
    await box.clear();
  }

  Future<void> close() async {
    await Hive.close();
  }
}
