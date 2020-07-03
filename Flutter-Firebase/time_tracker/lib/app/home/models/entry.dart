import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Entry {
  Entry({
    @required this.id,
    @required this.jobId,
    @required this.start,
    @required this.end,
    this.comment,
  });

  String id;
  String jobId;
  DateTime start;
  DateTime end;
  String comment;

  double get durationInHour =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Entry.fromMap(Map<String, dynamic> value, String id) {
    final int startMillisecond = value['start'];
    final int endMillisecond = value['end'];

    return Entry(
        id: id,
        jobId: value['jobId'],
        start: DateTime.fromMillisecondsSinceEpoch(startMillisecond),
        end: DateTime.fromMillisecondsSinceEpoch(endMillisecond),
        comment: value['comment']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
    };
  }
}
