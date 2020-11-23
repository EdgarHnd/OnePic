import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onepic/main.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'screens.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

TValue case2<TOptionType, TValue>(
  TOptionType selectedOption,
  Map<TOptionType, TValue> branches, [
  TValue defaultValue,
]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }

  return branches[selectedOption];
}

class _HomePageState extends State<HomePage> {
  int _page = 1;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    UserModel currentUser = Provider.of<UserModel>(context);
    if (currentUser != null) {
      return (Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(case2(_page, {0: "Lit", 1: "Feed", 2: "Profile"}, "Feed"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
        ),
        body: PageView(
          controller: pageController,
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Text("Lit"),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(child: FeedScreen()),
            ),
            Container(
              color: Colors.white,
              child:
                  ProfileScreen() /* Center(
                child: Text("Profile"), */
              ,
            ),
          ],
          scrollDirection: Axis.horizontal,
          /* physics: AlwaysScrollableScrollPhysics(), */
          /* physics: NeverScrollableScrollPhysics(), */
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: (_page == 0)
                    ? Icon(CupertinoIcons.flame_fill, color: Colors.black)
                    : Icon(CupertinoIcons.flame, color: Colors.grey),
                title: Container(height: 0.0),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.tornado,
                    color: (_page == 1) ? Colors.black : Colors.grey),
                title: Container(height: 0.0),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: (_page == 2)
                    ? Icon(CupertinoIcons.person_fill, color: Colors.black)
                    : Icon(CupertinoIcons.person, color: Colors.grey),
                title: Container(height: 0.0),
                backgroundColor: Colors.white),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ));
    } else {
      return (LoginScreen());
    }
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
