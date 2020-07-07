import 'package:flutter/foundation.dart';

class JobDetails {
  JobDetails({
    @required this.name,
    @required this.durationHours,
    @required this.pay,
  });

  final String name;
  double durationHours;
  double pay;
}
