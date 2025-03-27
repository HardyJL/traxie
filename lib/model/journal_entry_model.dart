import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:traxie/extensions/date_extensions.dart';
part 'journal_entry_model.g.dart';

@HiveType(typeId: 1)
class JournalEntryModel extends HiveObject implements Comparable<JournalEntryModel> {
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

  @override
  int compareTo(JournalEntryModel other) {
    return this.trackingDate.noTime.compareTo(other.trackingDate.noTime);
  }

  @override
  bool operator ==(Object other) {
    if (other is JournalEntryModel) {
      return this.trackingDate.isSameDate(other.trackingDate);
    }
    return false;
  }
}
