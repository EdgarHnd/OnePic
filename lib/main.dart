import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/services.dart';
import 'screens/screens.dart';
import 'shared/shared.dart';
import 'package:provider/provider.dart';

FirebaseAnalytics analytics;
User currentUserModel;
void main() {
  /* Crashlytics.instance.enableInDevMode =
      true; // turn this off after seeing reports in in the console.
  FlutterError.onError = Crashlytics.instance.recordFlutterError; */
  analytics = FirebaseAnalytics();
  runApp(OnePic());
}

class OnePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<FirebaseUser>.value(value: AuthService().user)
        ],
        child: CupertinoApp(
          title: 'OnePic',
          // Firebase Analytics
          /* navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ], */
          theme: CupertinoThemeData(),
          home: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

PageController pageController;

class _HomePageState extends State<HomePage> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    if (user != null) {
      return (Scaffold(
        body: PageView(
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Text("Feed"),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Text("Home"),
              ),
            ),
            Container(
              color: Colors.white,
              child:
                  ProfileScreen() /* Center(
                child: Text("Profile"), */
              ,
            ),
          ],
          controller: pageController,
          scrollDirection: Axis.horizontal,
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
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
