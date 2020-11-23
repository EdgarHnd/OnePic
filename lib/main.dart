import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/services.dart';
import 'screens/screens.dart';
import 'shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/* FirebaseAnalytics analytics; */
/* UserModel currentUserModel;
final usersCollection = FirebaseFirestore.instance.collection('users');

Future<void> retriveUserData(User user) async {
  DocumentSnapshot userRecord = await usersCollection.doc(user.uid).get();
  currentUserModel = UserModel.fromDocument(userRecord);
} */

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /* Crashlytics.instance.enableInDevMode =
      true; // turn this off after seeing reports in in the console.
  FlutterError.onError = Crashlytics.instance.recordFlutterError; */
  /* analytics = FirebaseAnalytics(); */
  runApp(OnePic());
}

class OnePic extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
                providers: [
                  StreamProvider<UserModel>.value(
                      value: Global.userDataRef.documentStream),
                  StreamProvider<User>.value(value: FirebaseAuthHelper().user)
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

            // Otherwise, show something whilst waiting for initialization to complete
          }
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Loading"),
              ),
            ),
          );
        });
  }
}
