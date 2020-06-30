import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
    );
  }

  Future<void> _createJob(BuildContext context) async {
    try {
      final database = Provider.of<DataBase>(context, listen: false);
      await database.createJob(Job(name: 'Manager', ratePerHour: 12));
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
