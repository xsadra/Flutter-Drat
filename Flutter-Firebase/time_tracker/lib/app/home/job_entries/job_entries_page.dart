import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/home/job_entries/entry_list_item.dart';
import 'package:timetracker/app/home/job_entries/entry_page.dart';
import 'package:timetracker/app/home/jobs/edit_job_page.dart';
import 'package:timetracker/app/home/jobs/list_items_builder.dart';
import 'package:timetracker/app/home/models/entry.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/database.dart';
import 'package:timetracker/widgets/platform/platform_exception_alert_dialog.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({
    Key key,
    @required this.database,
    @required this.job,
  }) : super(key: key);

  final Database database;
  final Job job;

  static Future<void> show({BuildContext context, Job job}) async {
    final Database database = Provider.of<Database>(context, listen: false);
    var route = MaterialPageRoute(
      builder: (context) => JobEntriesPage(database: database, job: job),
      fullscreenDialog: false,
    );
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Job>(
        stream: database.jobStream(jobId: job.id),
        builder: (context, snapshot) {
          final job = snapshot.data;
          final jobName = job?.name ?? '';
          return Scaffold(
            appBar: AppBar(
              title: Text(jobName),
              centerTitle: true,
              elevation: 2.0,
              actions: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () => EditJobPage.show(
                    context,
                    database: database,
                    job: job,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () => EntryPage.show(
                    job: job,
                    database: database,
                    context: context,
                  ),
                ),
              ],
            ),
            body: _buildContent(context, job),
          );
        });
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              job: job,
              entry: entry,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                job: job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}
