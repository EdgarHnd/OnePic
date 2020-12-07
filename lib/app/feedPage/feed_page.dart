import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/routing/router.gr.dart';
import 'package:onepic/services/providers.dart';

class FeedPage extends HookWidget {
  final ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final onesList = watch(onesProvider);
        return onesList.when(
          data: (ones) => ListView(
            controller: _scrollController,
            children: <Widget>[
              for (var one in ones)
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.userPage,
                              arguments: UserPageArguments(userId: one.uid));
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
                                      Text(one.username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline),
                                      Text(one.nbLikes.toString(),
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
            ],
          ),
          loading: () => CircularProgressIndicator(),
          error: (_, __) => Container(),
        );
      }),
    );
  }
}
