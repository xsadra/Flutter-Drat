import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetracker/app/home/models/entry.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/database.dart';
import 'package:timetracker/widgets/platform/platform_exception_alert_dialog.dart';

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
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;
  String _comment;

  @override
  void initState() {
    super.initState();
    final start = widget.entry?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final end = widget.entry?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);

    _comment = widget.entry?.comment ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job.name),
        actions: [
          FlatButton(
            onPressed: () => _setEntryAndDismiss(context),
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

  Future<void> _setEntryAndDismiss(BuildContext context) async {
    try {
      final entry = _entryFromState();
      await widget.database.setEntry(entry);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  Entry _entryFromState() {
    final start = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _startTime.hour,
      _startTime.minute,
    );

    final end = DateTime(
      _endDate.year,
      _endDate.month,
      _endDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    final id = widget.entry?.id ?? documentIdFromCurrentDate();

    return Entry(
      id: id,
      jobId: widget.job.id,
      start: start,
      end: end,
      comment: _comment,
    );
  }
}
