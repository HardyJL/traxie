// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appBarTitle => 'traxie';

  @override
  String get calendarNav => 'Calendar';

  @override
  String get overviewNav => 'Overview';

  @override
  String get historyNav => 'History';

  @override
  String nextPeriod(int daysamount) {
    return 'Your next period is estimated to be in $daysamount days';
  }

  @override
  String currentPeriod(String day) {
    return 'You are currently having your $day period day.';
  }

  @override
  String currentPeriodLasting(int daysamount) {
    return 'It should last for $daysamount more days.';
  }

  @override
  String daysLasting(int daysamount) {
    return 'And should last $daysamount days';
  }

  @override
  String fromToDate(String fromDate, String toDate) {
    return 'From $fromDate to $toDate';
  }

  @override
  String get nothingAdded => 'Please add your first period';

  @override
  String get onceAddedShow =>
      'Once you\'ve added your first period, you will see an overview here.';
}
