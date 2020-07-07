import 'package:flutter/foundation.dart';
import 'package:timetracker/app/home/entries/entry_job.dart';
import 'package:timetracker/app/home/entries/job_details.dart';

class DailyJobsDetails {
  DailyJobsDetails({
    @required this.date,
    @required this.jobDetails,
  });

  final DateTime date;
  final List<JobDetails> jobDetails;

  double get pay => jobDetails
      .map((job) => job.pay)
      .reduce((value, element) => value + element);

  double get duration => jobDetails
      .map((job) => job.durationHours)
      .reduce((value, element) => value + element);

  static List<DailyJobsDetails> all(List<EntryJob> entryJobs) {
    final allEntriesSortedByDate = _entriesByDate(entryJobs);
    List<DailyJobsDetails> result = [];
    for (var date in allEntriesSortedByDate.keys) {
      final entryJobsSeparatedByDate = allEntriesSortedByDate[date];
      final jobDetails = _jobDetails(entryJobsSeparatedByDate);
      result.add(DailyJobsDetails(date: date, jobDetails: jobDetails));
    }
    return result;
  }

  static Map<DateTime, List<EntryJob>> _entriesByDate(
      List<EntryJob> entryJobs) {
    Map<DateTime, List<EntryJob>> result = {};
    for (var entryJob in entryJobs) {
      final entryStart = entryJob.entry.start;
      final entryDayStart =
          DateTime(entryStart.year, entryStart.month, entryStart.day);

      if (result[entryDayStart] == null) {
        result[entryDayStart] = [entryJob];
      } else {
        result[entryDayStart].add(entryJob);
      }
    }
    return result;
  }

  static List<JobDetails> _jobDetails(List<EntryJob> entryJobs) {
    Map<String, JobDetails> jobDuration = {};
    for (var entryJob in entryJobs) {
      final entry = entryJob.entry;
      final job = entryJob.job;
      final pay = entry.durationInHour * job.ratePerHour;

      if (jobDuration[entry.jobId] == null) {
        jobDuration[entry.jobId] = JobDetails(
          name: job.name,
          durationHours: entry.durationInHour,
          pay: pay,
        );
      } else {
        jobDuration[entry.jobId].pay += pay;
        jobDuration[entry.jobId].durationHours += entry.durationInHour;
      }
    }
    return jobDuration.values.toList();
  }
}
