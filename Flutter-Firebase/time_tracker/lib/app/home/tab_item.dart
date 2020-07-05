import 'package:flutter/material.dart';

enum TabItem {
  JOBS,
  ENTRIES,
  ACCOUNT,
}

class TabItemData {
 const TabItemData({
    @required this.title,
    @required this.icon,
  });

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.JOBS: TabItemData(title: 'Jobs', icon: Icons.work),
    TabItem.ENTRIES: TabItemData(title: 'Entries', icon: Icons.view_headline),
    TabItem.ACCOUNT: TabItemData(title: 'Account', icon: Icons.person),
  };
}
