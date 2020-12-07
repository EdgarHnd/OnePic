import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/app/accountPage/account_page.dart';
import 'package:onepic/app/feedPage/feed_page.dart';
import 'package:onepic/app/homePage/bottom_nav.dart';
import 'package:onepic/app/trends_page/trends_page.dart';
import 'navigation_state.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pageModel = useProvider(navigationStateProvider.state);
    final currentPage = useState(1);

    /* Widget body;
    switch (pageModel.page) {
      case NavigationBarEvent.Trends:
        body = TrendsPage();
        break;
      case NavigationBarEvent.Feed:
        body = FeedPage();
        break;
      case NavigationBarEvent.Account:
        body = AccountPage();
        break;
    } */
    switch (pageModel.page) {
      case NavigationBarEvent.Trends:
        currentPage.value = 0;
        break;
      case NavigationBarEvent.Feed:
        currentPage.value = 1;
        break;
      case NavigationBarEvent.Account:
        currentPage.value = 2;
        break;
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                CupertinoIcons.search,
                color: Colors.black,
              ),
            )
          ],
          title: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("OneLit",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.white,
        ),
        body: IndexedStack(
          index: currentPage.value,
          children: [TrendsPage(), FeedPage(), AccountPage()],
        ),
        bottomNavigationBar: BottomNav());
  }
}
