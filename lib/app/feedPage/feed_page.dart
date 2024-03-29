import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/app/onePage/one_page_model.dart';
import 'package:onepic/app/userPage/user_page.dart';
import 'package:onepic/routing/router.gr.dart';
import 'package:onepic/services/global.dart';
import 'package:onepic/services/providers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedPage extends HookWidget {
  final ScrollController _scrollController = new ScrollController();
  final onePageModel = OnePageModel();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          labelColor: AppColors.purple,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              text: 'Following',
            ),
            Tab(
              text: 'For you',
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[
            Consumer(
              builder: (context, watch, child) {
                final followingUsersList = watch(followingUsersProvider);
                return followingUsersList.when(
                  data: (users) => ListView(
                    /* overAndUnderCenterOpacity: 0.4, */
                    /* useMagnifier: false, */
                    /* diameterRatio: 6,
                    itemExtent: 500,
                    renderChildrenOutsideViewport: false, */
                    controller: _scrollController,
                    children: <Widget>[
                      for (var user in users)
                        Consumer(
                          builder: (context, watch, child) {
                            final followingUserOne =
                                watch(oneProvider(user.one));
                            return followingUserOne.when(
                              data: (one) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {
                                        final liked = context
                                            .read(currentUserProvider)
                                            .data
                                            .value
                                            .id;
                                        if (one.likes.contains(liked)) {
                                          onePageModel.unLike(one.id, liked);
                                        } else {
                                          onePageModel.like(one.id, liked);
                                        }
                                      },
                                      onTap: () {
                                        /* Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserPage(userId: one.uid))); */
                                        Navigator.of(context).pushNamed(
                                            Routes.userPage,
                                            arguments: UserPageArguments(
                                                userId: one.uid,
                                                oneUrl: one.url));
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Hero(
                                              transitionOnUserGestures: true,
                                              tag: one.url,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: Container(
                                                  child: CachedNetworkImage(
                                                    imageUrl: one.url,
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ), /* Image.network(one.url), */
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(one.username,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .hotjar,
                                                            color:
                                                                AppColors.red,
                                                            size: 25,
                                                          ),
                                                        ),
                                                        Text(
                                                            one.nbLikes
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline4),
                                                      ],
                                                    ),
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
                              ),
                              loading: () => CircularProgressIndicator(),
                              error: (_, __) => Container(),
                            );
                          },
                        ),
                    ],
                  ),
                  loading: () => CircularProgressIndicator(),
                  error: (_, __) => Container(),
                );
              },
            ),
            Consumer(
              builder: (context, watch, child) {
                final onesList = watch(allCurrentOnesProvider);
                return onesList.when(
                  data: (ones) => ListView(
                    /* overAndUnderCenterOpacity: 0.4, */
                    /* useMagnifier: false, */
                    /* diameterRatio: 6,
                    itemExtent: 500,
                    renderChildrenOutsideViewport: false, */
                    controller: _scrollController,
                    children: <Widget>[
                      for (var one in ones)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  final liked = context
                                      .read(currentUserProvider)
                                      .data
                                      .value
                                      .id;
                                  if (one.likes.contains(liked)) {
                                    onePageModel.unLike(one.id, liked);
                                  } else {
                                    onePageModel.like(one.id, liked);
                                  }
                                },
                                onTap: () {
                                  /* Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserPage(userId: one.uid))); */
                                  Navigator.of(context).pushNamed(
                                      Routes.userPage,
                                      arguments: UserPageArguments(
                                          userId: one.uid, oneUrl: one.url));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Hero(
                                        transitionOnUserGestures: true,
                                        tag: one.url,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageUrl: one.url,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ), /* Image.network(one.url), */
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(one.username,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Icon(
                                                      FontAwesomeIcons.hotjar,
                                                      color: AppColors.red,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  Text(one.nbLikes.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4),
                                                ],
                                              ),
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
                    ],
                  ),
                  loading: () => CircularProgressIndicator(),
                  error: (_, __) => Container(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
