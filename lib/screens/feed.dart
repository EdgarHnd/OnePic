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
            return ListView(controller: _scrollController, children: <Widget>[
              for (var user in users)
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(upRoute(ProfileScreen(
                            userProfile: user,
                          )));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/kanye.jpg'))),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(user.username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline),
                                      Text(user.likes.toString(),
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ]);
          } else {
            return CircularProgressIndicator();
            /* Container(
              color: Colors.white,
              child: Center(
                child: Text("Nobody here"),
              ),
            ); */
          }
        });
  }
}
