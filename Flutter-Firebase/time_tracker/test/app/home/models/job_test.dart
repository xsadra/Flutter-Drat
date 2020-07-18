import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/app/home/models/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final job = Job.fromMap(null, 'did-123');
      expect(job, null);
    });

    test('job with all properties', () {
      final job = Job.fromMap(
        {'name': 'Developer', 'ratePerHour': 10},
        'did-123',
      );
      expect(
        job,
        Job(id: 'did-123', name: 'Developer', ratePerHour: 10),
      );
    });

    test('missing name', () {
      final job = Job.fromMap(
        {'ratePerHour': 10},
        'did-123',
      );
      expect(job, null);
    });
  });
}
