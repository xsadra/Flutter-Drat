import 'package:flutter/material.dart';
import 'package:timetracker/app/home/job_entries/format.dart';
import 'package:timetracker/app/home/models/entry.dart';
import 'package:timetracker/app/home/models/job.dart';

class EntryListItem extends StatelessWidget {
  const EntryListItem({
    Key key,
    @required this.entry,
    @required this.job,
    @required this.onTap,
  }) : super(key: key);
  final Entry entry;
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(child: _buildContents(context)),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final dayOfWeek = Format.dayOfWeek(entry.start);
    final startDate = Format.date(entry.start);
    final startTime = TimeOfDay.fromDateTime(entry.start).format(context);
    final endTime = TimeOfDay.fromDateTime(entry.end).format(context);
    final durationFormatted = Format.hours(entry.durationInHour);

    final pay = job.ratePerHour * entry.durationInHour;
    final payFormatted = Format.currency(pay);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(
            dayOfWeek,
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(startDate, style: TextStyle(fontSize: 18.0)),
          if (job.ratePerHour > 0.0) ...[
            Expanded(child: Container()),
            Text(
              payFormatted,
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ]
        ]),
        Row(children: [
          Text('$startTime - $endTime', style: TextStyle(fontSize: 16.0)),
          Expanded(child: Container()),
          Text(durationFormatted, style: TextStyle(fontSize: 16.0)),
        ]),
        if (entry.comment.isNotEmpty)
          Text(
            entry.comment,
            style: TextStyle(fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}
