import 'package:flutter/material.dart';
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

  _buildContents(BuildContext context) {}
}
