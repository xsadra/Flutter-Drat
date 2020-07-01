import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/database.dart';
import 'package:timetracker/widgets/platform/platform_alert_dialog.dart';
import 'package:timetracker/widgets/platform/platform_exception_alert_dialog.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key key, @required this.database}) : super(key: key);
  final DataBase database;

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<DataBase>(context, listen: false);
    var route = MaterialPageRoute(
      builder: (context) => AddJobPage(database: database),
      fullscreenDialog: true,
    );
    await Navigator.of(context).push(route);
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Job'),
        actions: [
          FlatButton(
            onPressed: _submit,
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job name'),
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (newValue) => _name = newValue,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate per hour'),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (newValue) => _ratePerHour = int.tryParse(newValue) ?? 0,
      ),
    ];
  }

  Future<void> _submit() async {
    if (!_validateAndSaveForm()) {
      return;
    }
    try {
      final jobs = await widget.database.jobsStream().first;
      final jobsName = jobs.map((job) => job.name).toList();

      if (jobsName.contains(_name)) {
        PlatformAlertDialog(
          title: 'Name already used',
          content: 'Please choose a different job name',
          defaultActionText: 'OK',
        ).show(context);
        return;
      }

      final job = Job(name: _name, ratePerHour: _ratePerHour);
      await widget.database.createJob(job);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Add new Job failed',
        exception: e,
      ).show(context);
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
