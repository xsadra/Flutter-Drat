import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/home/job_entries/job_entries_page.dart';
import 'package:timetracker/app/home/jobs/edit_job_page.dart';
import 'package:timetracker/app/home/jobs/job_list_tile.dart';
import 'package:timetracker/app/home/jobs/list_items_builder.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/auth.dart';
import 'package:timetracker/services/database.dart';
import 'package:timetracker/widgets/platform/platform_alert_dialog.dart';
import 'package:timetracker/widgets/platform/platform_exception_alert_dialog.dart';

class JobsPage extends StatelessWidget {
  Future<void> _confirmSignOut(BuildContext context) async {
    final confirm = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);

    if (confirm) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(
          context,
          database: Provider.of<Database>(context, listen: false),
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(
              padding: EdgeInsets.only(right: 18.0),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white, size: 36.0),
              alignment: Alignment.centerRight,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context: context, job: job),
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}
