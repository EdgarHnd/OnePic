import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:onepic/app/onePage/one_page_model.dart';
import 'package:onepic/app/userPage/user_page_model.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/models.dart';
import 'package:onepic/services/providers.dart';

class UserPage extends HookWidget {
  final userPageModel = UserPageModel();

  final String userId;
  UserPage({Key key, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = useProvider(userProvider(userId));
    final currentUid = useProvider(currentUserIdProvider);
    return userModel.when(
      data: (user) {
        if (user != null) {
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
                      Consumer(builder: (context, watch, child) {
                        final isFollowed = watch(isFollowedProvider(userId));
                        return isFollowed.when(
                          data: (follow) => FlatButton(
                            child: (!follow)
                                ? Text(
                                    'follow',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text('unfollow',
                                    style: TextStyle(color: Colors.white)),
                            color: (!follow) ? Colors.black : Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            onPressed: () {
                              if (follow) {
                                userPageModel.unFollow(user.id, currentUid);
                              } else {
                                userPageModel.follow(user.id, currentUid);
                              }
                            },
                          ),
                          loading: () => FlatButton(
                            onPressed: () {},
                            child: Text('loading'),
                          ),
                          error: (_, __) => Container(),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(user.username ?? 'username',
                              style: TextStyle(
                                  color: Colors.purpleAccent, fontSize: 30)),
                          Column(
                            children: [
                              Text(user.nbFollowers.toString() + ' follows',
                                  style: Theme.of(context).textTheme.headline),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    CupertinoIcons.staroflife_fill,
                                    color: Colors.amber,
                                  ),
                                  Text('230',
                                      style:
                                          Theme.of(context).textTheme.headline),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      UserOne(oneId: user.one),
                    ],
                  ),
                ),
              ));
        } else {
          return Container(child: Text('User does not exist'));
        }
      },
      loading: () => CircularProgressIndicator(),
      error: (_, __) => Container(),
    );
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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onLongPress: () {
                    final liked = context.read(currentUserIdProvider);
                    if (userOne.likes.contains(liked)) {
                      onePageModel.unLike(userOne.id, liked);
                    } else {
                      onePageModel.like(userOne.id, liked);
                    }
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          child: Image(
                              image: AssetImage('assets/images/kanye.jpg')))),
                ),
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
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
