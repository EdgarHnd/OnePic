import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/services/global.dart';
import 'navigation_state.dart';

class BottomNav extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pageModel = useProvider(navigationStateProvider.state);
    return Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: CupertinoTabBar(
          border: Border(top: BorderSide.none),
          iconSize: 35,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: (pageModel.page == NavigationBarEvent.Trends)
                    ? Icon(CupertinoIcons.flame_fill, color: Colors.black)
                    : Icon(CupertinoIcons.flame, color: AppColors.orange),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.tornado,
                    color: (pageModel.page == NavigationBarEvent.Feed)
                        ? Colors.black
                        : AppColors.pink),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: (pageModel.page == NavigationBarEvent.Account)
                    ? Icon(CupertinoIcons.person_fill, color: Colors.black)
                    : Icon(CupertinoIcons.person, color: AppColors.purple),
                backgroundColor: Colors.white),
          ],
          onTap: context.read(navigationStateProvider).selectPage,
        ));
  }
}
