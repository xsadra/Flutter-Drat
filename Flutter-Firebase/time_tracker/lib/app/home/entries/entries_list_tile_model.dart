import 'package:flutter/foundation.dart';

class EntriesListTileModel {
  EntriesListTileModel({
    @required this.leadingText,
    @required this.trailingText,
    this.middleText,
    this.isHeader = false,
  });

  final String leadingText;
  final String trailingText;
  final String middleText;
  final bool isHeader;
}
