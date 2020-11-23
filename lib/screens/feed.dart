import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'screens.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Global.usersRef.getData(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<UserModel> users = snap.data;
            return ListView(
              controller: _scrollController,
              children: <Widget>[
                for (var user in users)
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                            child: Image(image: AssetImage('meeseek.jpg'))),
                        ListTile(
                          title: Text(user.username),
                        ),
                      ],
                    ),
                  )
              ],
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text("Nobody here"),
              ),
            );
          }
        });
  }
}
