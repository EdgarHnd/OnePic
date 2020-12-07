import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:onepic/app/onePage/one_page_model.dart';
import 'package:onepic/app/userPage/user_page_model.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/models.dart';
import 'package:onepic/services/providers.dart';

class UserPage extends StatelessWidget {
  final userPageModel = UserPageModel();
  final String userId;
  UserPage({Key key, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: Document<UserModel>(path: 'users/$userId').streamData(),
        builder: (BuildContext context, AsyncSnapshot user) {
          if (user.hasData) {
            UserModel userModel = user.data;
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
                          onPressed: () {
                            final currentUid =
                                context.read(currentUserIdProvider);
                            if (userModel.followers.contains(currentUid)) {
                              userPageModel.unFollow(userModel.id, currentUid);
                            } else {
                              userPageModel.follow(userModel.id, currentUid);
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(userModel.username ?? 'username',
                                style: TextStyle(
                                    color: Colors.purpleAccent, fontSize: 30)),
                            Column(
                              children: [
                                Text(
                                    userModel.nbFollowers.toString() +
                                        ' follows',
                                    style:
                                        Theme.of(context).textTheme.headline),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.staroflife_fill,
                                      color: Colors.amber,
                                    ),
                                    Text('230',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        UserOne(oneId: userModel.one),
                      ],
                    ),
                  ),
                ));
          } else {
            return Container();
          }
        });
  }
}

class UserOne extends StatelessWidget {
  UserOne({
    Key key,
    @required this.oneId,
  }) : super(key: key);

  final String oneId;
  final onePageModel = OnePageModel();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Document<OneModel>(path: 'ones/' + oneId).streamData(),
      builder: (BuildContext context, AsyncSnapshot one) {
        if (one.hasData) {
          OneModel userOne = one.data;
          return Column(
            children: [
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
                  Text(userOne.nbLikes.toString(),
                      style: TextStyle(color: Colors.redAccent, fontSize: 40)),
                ],
              ),
              IconButton(
                icon: Icon(CupertinoIcons.flame_fill),
                iconSize: 50,
                color: Colors.amberAccent,
                onPressed: () {
                  final liked = context.read(currentUserIdProvider);
                  if (userOne.likes.contains(liked)) {
                    onePageModel.unLike(userOne.id, liked);
                  } else {
                    onePageModel.like(userOne.id, liked);
                  }
                },
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
