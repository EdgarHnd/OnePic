import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Colors.white,
        ));
  }
}
