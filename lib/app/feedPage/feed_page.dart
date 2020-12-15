import 'package:auto_route/auto_route_annotations.dart';
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
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final onesList = watch(allCurrentOnesProvider);
        return onesList.when(
          data: (ones) => ListView(
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
                          final liked = context.read(currentUserIdProvider);
                          if (one.likes.contains(liked)) {
                            onePageModel.unLike(one.id, liked);
                          } else {
                            onePageModel.like(one.id, liked);
                          }
                        },
                        onTap: () {
                          /* Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserPage(userId: one.uid))); */
                          Navigator.of(context).pushNamed(Routes.userPage,
                              arguments: UserPageArguments(userId: one.uid));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Hero(
                                tag: one.id,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    child: CachedNetworkImage(
                                      imageUrl: one.url,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
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
                                      Hero(
                                        tag: one.uid,
                                        child: Text(one.username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ),
                                      Hero(
                                        tag: 'like${one.uid}',
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
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
      }),
    );
  }
}
