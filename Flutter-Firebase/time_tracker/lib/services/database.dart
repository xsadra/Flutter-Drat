import 'package:flutter/foundation.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/api_path.dart';
import 'package:timetracker/services/firestore_service.dart';

abstract class DataBase {
  Future<void> createJob(Job job);

  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDate() =>
    DateTime.now().millisecondsSinceEpoch.toString();

class FirestoreDatabase implements DataBase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _service = FirestoreService.instance;

  Future<void> createJob(Job job) async => await _service.setData(
        path: ApiPath.job(uid, documentIdFromCurrentDate()),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
