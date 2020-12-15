import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:onepic/app/homePage/home_page.dart';
import 'package:onepic/app/onePage/one_page_model.dart';
import 'package:onepic/app/userPage/user_page_model.dart';
import 'package:onepic/services/db.dart';
import 'package:onepic/services/global.dart';
import 'package:onepic/services/models.dart';
import 'package:onepic/services/providers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserPage extends HookWidget {
  final userPageModel = UserPageModel();

  final String userId;
  UserPage({Key key, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = useProvider(userProvider(userId));
    final currentUid = useProvider(currentUserIdProvider);
    final onePageModel = OnePageModel();
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
                /* appBar: AppBar(
                  centerTitle: true,
                  title: Hero(tag: 'logo', child: LogoText()),
                  backgroundColor: Colors.white,
                ), */
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: SizedBox(
                          height: 30,
                        ),
                      ),
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
                            color: (!follow) ? Colors.black : AppColors.orange,
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
                          Hero(
                            tag: userId,
                            child: Text(user.username ?? 'username',
                                style: Theme.of(context).textTheme.headline1),
                          ),
                          Column(
                            children: [
                              Text(user.nbFollowers.toString() + ' follows',
                                  style: Theme.of(context).textTheme.headline2),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        FontAwesomeIcons.crown,
                                        color: AppColors.orange,
                                        size: 20,
                                      ),
                                    ),
                                    Text('230',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      /*  UserOne(oneId: user.one) */ Consumer(
                        builder: (context, watch, child) {
                          final userOne = watch(userOnesProvider(userId));
                          return userOne.when(
                              data: (one) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 10),
                                        child: GestureDetector(
                                          onLongPress: () {
                                            final liked = context
                                                .read(currentUserIdProvider);
                                            if (one.likes.contains(liked)) {
                                              onePageModel.unLike(
                                                  one.id, liked);
                                            } else {
                                              onePageModel.like(one.id, liked);
                                            }
                                          },
                                          child: Hero(
                                            tag: one.id,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: CachedNetworkImage(
                                                imageUrl: one.url,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Hero(
                                        tag: 'like$userId',
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Icon(
                                                FontAwesomeIcons.hotjar,
                                                color: AppColors.red,
                                                size: 35,
                                              ),
                                            ),
                                            Text(one.nbLikes.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              loading: () => CircularProgressIndicator(),
                              error: (e, __) => Container(
                                    child: Text(e.toString()),
                                  ));
                        },
                      ),
                      Container(
                        child: SizedBox(
                          height: 30,
                        ),
                      ),
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
/* 
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: GestureDetector(
                  onLongPress: () {
                    final liked = context.read(currentUserIdProvider);
                    if (userOne.likes.contains(liked)) {
                      onePageModel.unLike(userOne.id, liked);
                    } else {
                      onePageModel.like(userOne.id, liked);
                    }
                  },
                  child: Hero(
                    tag: userOne.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Consumer(
                        builder: (context, watch, child) {
                          final imgUrl = watch(imgUrlProvider(oneId));
                          return imgUrl.when(
                            data: (url) => Image.network(url),
                            loading: () => CircularProgressIndicator(),
                            error: (e, __) => Container(
                              child: Text(e.toString()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'like$oneId',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        FontAwesomeIcons.hotjar,
                        color: AppColors.red,
                        size: 35,
                      ),
                    ),
                    Text(userOne.nbLikes.toString(),
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
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
 */
