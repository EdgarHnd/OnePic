import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/app/accountPage/account_page.dart';
import 'package:onepic/app/feedPage/feed_page.dart';
import 'package:onepic/app/homePage/bottom_nav.dart';
import 'package:onepic/app/trends_page/trends_page.dart';
import 'package:onepic/services/global.dart';
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
          elevation: 0,
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
            padding: const EdgeInsets.only(left: 15),
            child: Hero(tag: 'logo', child: LogoText()),
          ),
          backgroundColor: Colors.white,
        ),
        body: IndexedStack(
          index: currentPage.value,
          children: [TrendsPage(), FeedPage(), AccountPage()],
        ),
        bottomNavigationBar: SizedBox(height: 65, child: BottomNav()));
  }
}

class LogoText extends StatelessWidget {
  final logoFont = GoogleFonts.bungee().fontFamily;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: 'O',
          style: TextStyle(
              color: AppColors.purple, fontFamily: logoFont, fontSize: 30),
        ),
        TextSpan(
          text: 'N',
          style: TextStyle(
              color: AppColors.rose, fontFamily: logoFont, fontSize: 30),
        ),
        TextSpan(
          text: 'E',
          style: TextStyle(
              color: AppColors.pink, fontFamily: logoFont, fontSize: 30),
        ),
        TextSpan(
          text: 'L',
          style: TextStyle(
              color: AppColors.red, fontFamily: logoFont, fontSize: 30),
        ),
        TextSpan(
          text: 'I',
          style: TextStyle(
              color: AppColors.orange, fontFamily: logoFont, fontSize: 30),
        ),
        TextSpan(
          text: 'T',
          style: TextStyle(
              color: AppColors.yellow, fontFamily: logoFont, fontSize: 30),
        ),
      ]),
    );
  }
}
