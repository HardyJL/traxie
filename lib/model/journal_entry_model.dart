import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'journal_entry_model.g.dart';

@HiveType(typeId: 1)
class JournalEntryModel extends HiveObject {
  JournalEntryModel({required this.trackingDate, required this.flowStrength, this.key = 0})
    : assert(flowStrength >= 0 && flowStrength <= 4, 'Strength must be between 0 and 4');

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) {
    return JournalEntryModel(
      trackingDate: DateTime.parse(json['trackingDate'] as String),
      flowStrength: json['flowStrength'] as int,
    );
  }
  int key;
  @HiveField(0)
  final DateTime trackingDate;

  @HiveField(1)
  int flowStrength;

  Map<String, dynamic> toJson() {
    return {'trackingDate': trackingDate.toLocal().toIso8601String(), 'flowStrength': flowStrength};
  }

  @override
  String toString() {
    return 'Flow - ${DateFormat('dd.MM.yyyy').format(trackingDate)} - ($flowStrength)';
  }

  JournalEntryModel copyWith({DateTime? date, int? value}) {
    return JournalEntryModel(
      trackingDate: date ?? trackingDate,
      flowStrength: value ?? flowStrength,
    );
  }
}
