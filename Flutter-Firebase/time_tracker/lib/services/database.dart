import 'package:flutter/foundation.dart';
import 'package:timetracker/app/home/models/entry.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/api_path.dart';
import 'package:timetracker/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>> jobsStream();

  Future<void> setEntry(Entry entry);

  Future<void> deleteEntry(Entry entry);

  Stream<List<Entry>> entriesStream({Job job});
}

String documentIdFromCurrentDate() =>
    DateTime.now().millisecondsSinceEpoch.toString();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) async => await _service.setData(
        path: ApiPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteJob(Job job) async =>
      await _service.deleteData(path: ApiPath.job(uid, job.id));

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _service.collectionStream<Entry>(
        path: ApiPath.entries(uid),
        builder: (data, documentId) => Entry.fromMap(data, documentId),
        queryBuilder: job == null
            ? null
            : (query) => query.where('jobId', isEqualTo: job.id),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );

  @override
  Future<void> deleteEntry(Entry entry) async => await _service.deleteData(
        path: ApiPath.entry(uid, entry.id),
      );

  @override
  Future<void> setEntry(Entry entry) async => await _service.setData(
        path: ApiPath.entry(uid, entry.id),
        data: entry.toMap(),
      );
}
