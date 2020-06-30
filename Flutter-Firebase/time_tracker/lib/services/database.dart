import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:timetracker/app/home/models/job.dart';

abstract class DataBase {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements DataBase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;

  Future<void> createJob(Job job) async {
    final path = '/users/$uid/jobs/job_abc';
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(job.toMap());
  }
}
