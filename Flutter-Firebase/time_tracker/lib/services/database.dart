import 'package:flutter/foundation.dart';

abstract class DataBase {}

class FirestoreDatabase implements DataBase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
}
