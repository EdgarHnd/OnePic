import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/services.dart';
import 'package:onepic/app/authPage/login_page.dart';

import 'app/authPage/auth_widget.dart';
import 'app/homePage/home_page.dart';
import 'routing/router.gr.dart' as routing;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /*  debugPrintGestureArenaDiagnostics = true; */
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  /* Crashlytics.instance.enableInDevMode =
      true; // turn this off after seeing reports in in the console.
  FlutterError.onError = Crashlytics.instance.recordFlutterError; */
  /* analytics = FirebaseAnalytics(); */
  runApp(ProviderScope(
    child: OnePic(),
  ));
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
            return MaterialApp(
              theme: ThemeData(),
              debugShowCheckedModeBanner: false,
              home: AuthWrapper(
                nonSignedInBuilder: (_) => LoginPage(),
                signedInBuilder: (_) => HomePage(),
              ),
              onGenerateRoute: routing.Router(),
              /*  builder: ExtendedNavigator.builder<routing.Router>(
                router: routing.Router(),
                // pass anything navigation related to ExtendedNav instead of MaterialApp
                /* initialRoute: ...
                   observers:...
         navigatorKey:...
         onUnknownRoute:...*/
              ), */
            );

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
