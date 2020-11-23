import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'screens.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Image(image: AssetImage('meeseek.jpg'))),
            ),
            Text(currentUser.username ?? 'username',
                style: Theme.of(context).textTheme.headline),
            Text(currentUser.followers.length.toString(),
                style: Theme.of(context).textTheme.headline),
            FlatButton(
                child: Text(
                  'logout',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                onPressed: () async {
                  await FirebaseAuthHelper().logout();
                  Navigator.of(context).push(_createRoute());
                }),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
