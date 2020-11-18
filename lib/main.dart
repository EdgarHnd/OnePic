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
        child: MaterialApp(
          title: 'OnePic',
          // Firebase Analytics
          /* navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ], */
          theme: ThemeData(),
          home: HomePage(),
        ));
  }
}
