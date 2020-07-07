import 'package:flutter/material.dart';
import 'package:timetracker/app/home/account/account_page.dart';
import 'package:timetracker/app/home/cupertino_home_scaffold.dart';
import 'package:timetracker/app/home/entries/entries_page.dart';
import 'package:timetracker/app/home/jobs/jobs_page.dart';
import 'package:timetracker/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.JOBS;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.JOBS: GlobalKey<NavigatorState>(),
    TabItem.ENTRIES: GlobalKey<NavigatorState>(),
    TabItem.ACCOUNT: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.JOBS: (_) => JobsPage(),
      TabItem.ENTRIES: (context) => EntriesPage.create(context),
      TabItem.ACCOUNT: (_) => AccountPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CoupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      _popToFirstRoute(tabItem);
      return;
    }
    setState(() => _currentTab = tabItem);
  }

  void _popToFirstRoute(TabItem tabItem) {
    navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
  }
}
