import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/home/entries/entries_bloc.dart';
import 'package:timetracker/app/home/entries/entries_list_tile.dart';
import 'package:timetracker/app/home/jobs/list_items_builder.dart';
import 'package:timetracker/services/database.dart';

class EntriesPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Provider<EntriesBloc>(
      create: (_) => EntriesBloc(database: database),
      child: EntriesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entries'),
        elevation: 2.0,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final bloc = Provider.of<EntriesBloc>(context, listen: false);
    return StreamBuilder(
      stream: bloc.entriesListTileModelStream,
      builder: (context, snapshot) => ListItemBuilder(
        snapshot: snapshot,
        itemBuilder: (context, model) => EntriesListTile(model: model),
      ),
    );
  }
}
