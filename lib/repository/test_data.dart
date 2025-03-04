import 'package:traxie/model/journal_entry_model.dart';
import 'package:traxie/model/period_model.dart';

final List<JournalEntryModel> journalEntryTestData = [
  // Dezember
  JournalEntryModel(trackingDate: DateTime(2024, 11, 18), flowStrength: 1),
  JournalEntryModel(trackingDate: DateTime(2024, 11, 19), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2024, 11, 20), flowStrength: 3),
  JournalEntryModel(trackingDate: DateTime(2024, 11, 21), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2024, 11, 22), flowStrength: 2),
  JournalEntryModel(trackingDate: DateTime(2024, 11, 23), flowStrength: 1),
  // Dezember
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
];

final List<PeriodModel> periodModelTestData = [
  PeriodModel(
    cycleLength: 35,
    periodLength: 6,
    periodStartDate: DateTime(2024, 11, 18),
    periodEndDate: DateTime(2024, 11, 23),
  ),
  PeriodModel(
    cycleLength: 25,
    periodLength: 6,
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
    cycleLength: 30,
    periodLength: 6,
    periodStartDate: DateTime(2025, 2, 16),
    periodEndDate: DateTime(2025, 2, 21),
  ),
];
