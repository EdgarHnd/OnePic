import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:provider/provider.dart';

class TrendScreen extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user != null) {
      return Scaffold(
        bottomNavigationBar: AppBottomNav(),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Trending"),
        ),
      );
    } else {
      return Text('not logged in...');
    }
  }
}
