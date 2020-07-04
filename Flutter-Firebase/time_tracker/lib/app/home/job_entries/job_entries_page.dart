import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/home/job_entries/entry_page.dart';
import 'package:timetracker/app/home/jobs/edit_job_page.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/database.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
        elevation: 2.0,
        actions: [
          FlatButton(
            onPressed: () => EditJobPage.show(context, job: job),
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            EntryPage.show(job: job, database: database, context: context),
        child: Icon(Icons.add),
      ),
    );
  }

  _buildContent() {}
}
