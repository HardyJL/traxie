import 'package:hive/hive.dart';
part 'journal_entry_model.g.dart';

@HiveType(typeId: 1)
class JournalEntryModel extends HiveObject {
  JournalEntryModel({required this.trackingDate, required this.flowStrength})
    : assert(flowStrength >= 0 && flowStrength <= 4, 'Strength must be between 0 and 4');

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) {
    return JournalEntryModel(
      trackingDate: DateTime.parse(json['trackingDate'] as String),
      flowStrength: json['flowStrength'] as int,
    );
  }
  @HiveField(0)
  final DateTime trackingDate;

  @HiveField(1)
  int flowStrength;

  Map<String, dynamic> toJson() {
    return {'trackingDate': trackingDate.toLocal().toIso8601String(), 'flowStrength': flowStrength};
  }

  @override
  String toString() {
    return 'FlowTrackingModel(trackingDate: $trackingDate, flowStrength: $flowStrength)';
  }
}
