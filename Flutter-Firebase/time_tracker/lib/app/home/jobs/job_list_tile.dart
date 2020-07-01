import 'package:flutter/material.dart';
import 'package:timetracker/app/home/models/job.dart';

class JobListTile extends StatelessWidget {
  const JobListTile({
    Key key,
    @required this.job,
    this.onTap,
  }) : super(key: key);
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.work),
      title: Text(job.name),
      subtitle: Text(job.ratePerHour.toString()),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
