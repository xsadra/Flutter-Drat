import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timetracker/app/home/entries/daily_jobs_details.dart';
import 'package:timetracker/app/home/entries/entries_list_tile_model.dart';
import 'package:timetracker/app/home/entries/entry_job.dart';
import 'package:timetracker/app/home/entries/job_details.dart';
import 'package:timetracker/app/home/job_entries/format.dart';
import 'package:timetracker/app/home/models/entry.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/database.dart';

class EntriesBloc {
  EntriesBloc({@required this.database});

  final Database database;

  Stream<List<EntriesListTileModel>> get entriesListTileModelStream =>
      _allEntriesStream.map(_createModels);

  Stream<List<EntryJob>> get _allEntriesStream => Rx.combineLatest2(
        database.entriesStream(),
        database.jobsStream(),
        _entriesJobsCombiner,
      );

  static List<EntryJob> _entriesJobsCombiner(
    List<Entry> entries,
    List<Job> jobs,
  ) =>
      entries.map((entry) {
        final job = jobs.firstWhere((job) => job.id == entry.jobId);
        return EntryJob(job: job, entry: entry);
      }).toList();

  List<EntriesListTileModel> _createModels(List<EntryJob> allEntries) {
    final allDailyJobsDetails = DailyJobsDetails.all(allEntries);
    final totalDuration = allDailyJobsDetails
        .map((entryJob) => entryJob.duration)
        .reduce((value, element) => value + element);

    final totalPay = allDailyJobsDetails
        .map((entryJob) => entryJob.pay)
        .reduce((value, element) => value + element);
    return <EntriesListTileModel>[
      EntriesListTileModel(
        leadingText: 'All Entries',
        middleText: Format.currency(totalPay),
        trailingText: Format.hours(totalDuration),
      ),
      for (DailyJobsDetails dailyJobDetails in allDailyJobsDetails) ...[
        EntriesListTileModel(
          isHeader: true,
          leadingText: Format.date(dailyJobDetails.date),
          middleText: Format.currency(dailyJobDetails.pay),
          trailingText: Format.hours(dailyJobDetails.duration),
        ),
        for (JobDetails jobDetails in dailyJobDetails.jobDetails)
          EntriesListTileModel(
            leadingText: jobDetails.name,
            middleText: Format.currency(jobDetails.pay),
            trailingText: Format.hours(jobDetails.durationHours),
          ),
      ],
    ];
  }
}
