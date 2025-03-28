import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/model/period_model.dart';

final List<JournalEntryModel> journalEntryTestData = [
  // December
  JournalEntryModel(trackingDate: DateTime(2024, 12, 23), flowStrength: 1),
  JournalEntryModel(trackingDate: DateTime(2024, 12, 24), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2024, 12, 25), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2024, 12, 26), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2024, 12, 27), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2024, 12, 28), flowStrength: 1),
  // Januar
  JournalEntryModel(trackingDate: DateTime(2025, 1, 17), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2025, 1, 18), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2025, 1, 19), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2025, 1, 20), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2025, 1, 21), flowStrength: 1),
  // Februar
  JournalEntryModel(trackingDate: DateTime(2025, 2, 16), flowStrength: 1),
  JournalEntryModel(trackingDate: DateTime(2025, 2, 17), flowStrength: 1),
  JournalEntryModel(trackingDate: DateTime(2025, 2, 18), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2025, 2, 19), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2025, 2, 20), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2025, 2, 21), flowStrength: 1),
  // March
  JournalEntryModel(trackingDate: DateTime(2025, 3, 16), flowStrength: 1),
  JournalEntryModel(trackingDate: DateTime(2025, 3, 17), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2025, 3, 18), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2025, 3, 19), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2025, 3, 20), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2025, 3, 21), flowStrength: 1),
];

final List<PeriodModel> periodModelTestData = [
  PeriodModel(
    periodLength: 6,
    cycleLength: 26,
    periodStartDate: DateTime(2024, 12, 23),
    periodEndDate: DateTime(2024, 12, 28),
  ),
  PeriodModel(
    periodLength: 5,
    cycleLength: 30,
    periodStartDate: DateTime(2025, 1, 17),
    periodEndDate: DateTime(2025, 1, 21),
  ),
  PeriodModel(
    periodLength: 6,
    cycleLength: 28,
    periodStartDate: DateTime(2025, 2, 16),
    periodEndDate: DateTime(2025, 2, 21),
  ),
];
