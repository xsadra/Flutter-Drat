import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timetracker/app/home/job_entries/format.dart';

void main() {
  group('hours', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });
    test('zero', () {
      expect(Format.hours(0), '0h');
    });
    test('negative', () {
      expect(Format.hours(-10), '0h');
    });
    test('decimal', () {
      expect(Format.hours(5.1), '5h');
    });
  });

  group('date - US Local', () {
    setUp(() async {
      Intl.defaultLocale = 'en-US';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2020-07-17', () {
      expect(
        Format.date(DateTime(2020, 7, 17)),
        'Jul 17, 2020',
      );
    });
  });

  group('date - GB Local', () {
    setUp(() async {
      Intl.defaultLocale = 'en-GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2020-07-17', () {
      expect(
        Format.date(DateTime(2020, 7, 17)),
        '17 Jul 2020',
      );
    });
  });

  group('dayOfWeek - US Local', () {
    setUp(() async {
      Intl.defaultLocale = 'en-US';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Monday', () {
      expect(
        Format.dayOfWeek(DateTime(2020, 7, 20)),
        'Mon',
      );
    });
  });
}
