import 'package:flutter/material.dart';
import 'package:timetracker/app/home/jobs/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }
    final List<T> items = snapshot.data;
    return items.isNotEmpty ? _buildList(items) : EmptyContent();
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => Card(
        child: itemBuilder(context, items[index]),
      ),
    );
  }
}
