import 'package:flutter/material.dart';
import 'package:timetracker/app/home/models/entry.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/database.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({
    Key key,
    @required this.job,
    @required this.database,
    this.entry,
  }) : super(key: key);
  final Job job;
  final Entry entry;
  final Database database;

  static Future<void> show({
    BuildContext context,
    Database database,
    Job job,
    Entry entry,
  }) async {
    var route = MaterialPageRoute(
      builder: (context) =>
          EntryPage(job: job, database: database, entry: entry),
    );
    await Navigator.of(context).push(route);
  }

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job.name),
        actions: [
          FlatButton(
            onPressed: null,
            child: Text(
              widget.entry == null ? 'Create' : 'Update',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(child: Container()),
    );
  }
}
