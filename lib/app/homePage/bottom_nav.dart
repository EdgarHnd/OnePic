import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'navigation_state.dart';

class BottomNav extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pageModel = useProvider(navigationStateProvider.state);
    return CupertinoTabBar(
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: (pageModel.page == NavigationBarEvent.Trends)
                ? Icon(CupertinoIcons.flame_fill, color: Colors.black)
                : Icon(CupertinoIcons.flame, color: Colors.grey),
            title: Container(height: 0.0),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tornado,
                color: (pageModel.page == NavigationBarEvent.Feed)
                    ? Colors.black
                    : Colors.grey),
            title: Container(height: 0.0),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: (pageModel.page == NavigationBarEvent.Account)
                ? Icon(CupertinoIcons.person_fill, color: Colors.black)
                : Icon(CupertinoIcons.person, color: Colors.grey),
            title: Container(height: 0.0),
            backgroundColor: Colors.white),
      ],
      onTap: context.read(navigationStateProvider).selectPage,
    );
  }
}
