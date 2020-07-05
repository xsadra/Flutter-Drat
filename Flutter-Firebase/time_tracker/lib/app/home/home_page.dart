import 'package:flutter/material.dart';
import 'package:timetracker/app/home/cupertino_home_scaffold.dart';
import 'package:timetracker/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.JOBS;

  @override
  Widget build(BuildContext context) {
    return CoupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectTab: _select,
    );
  }

  void _select(TabItem tabItem) {
    setState(() => _currentTab= tabItem);
  }
}
