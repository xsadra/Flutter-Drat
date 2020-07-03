import 'package:flutter/foundation.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/api_path.dart';
import 'package:timetracker/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>> jobsStream();
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
}
