import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'screens.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel userProfile;

  ProfileScreen({Key key, @required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                    child: Text(
                      'follow',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(userProfile.username ?? 'username',
                        style: TextStyle(
                            color: Colors.purpleAccent, fontSize: 30)),
                    Column(
                      children: [
                        Text(
                            userProfile.followers.length.toString() +
                                ' follows',
                            style: Theme.of(context).textTheme.headline),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              CupertinoIcons.staroflife_fill,
                              color: Colors.amber,
                            ),
                            Text('230',
                                style: Theme.of(context).textTheme.headline),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          child: Image(
                              image: AssetImage('assets/images/kanye.jpg')))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.flame_fill,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    Text(userProfile.likes.toString(),
                        style:
                            TextStyle(color: Colors.redAccent, fontSize: 40)),
                  ],
                ),
                IconButton(
                    icon: Icon(CupertinoIcons.flame_fill),
                    iconSize: 50,
                    color: Colors.amberAccent,
                    onPressed: () {
                      _updateLikes(userProfile);
                    }),
              ],
            ),
          ),
        ));
  }

  Future<void> _updateLikes(UserModel user) {
    Document<UserModel> oneUser = Document<UserModel>(path: 'ones/' + user.one);
    oneUser.upsert(({'nbLikes': FieldValue.increment(1)}));
  }
}
