import 'package:flutter/material.dart';
import 'package:timetracker/app/home/entries/entries_list_tile_model.dart';

class EntriesListTile extends StatelessWidget {
  const EntriesListTile({Key key, @required this.model}) : super(key: key);
  final EntriesListTileModel model;

  @override
  Widget build(BuildContext context) {
    const fontSize = 16.0;
    return Container(
      color: model.isHeader ? Colors.indigo[100] : null,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Text(model.leadingText, style: TextStyle(fontSize: fontSize)),
          Expanded(child: Container()),
          if (model.middleText != null)
            Text(
              model.middleText,
              style: TextStyle(
                color: Colors.green[700],
                fontSize: fontSize,
              ),
              textAlign: TextAlign.right,
            ),
          SizedBox(
            width: 60.0,
            child: Text(
              model.trailingText,
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
